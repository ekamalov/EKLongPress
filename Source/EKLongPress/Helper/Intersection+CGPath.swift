//
//  Intersection+CGPath.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 6/19/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit
import CoreGraphics

typealias RawImage = (options: ImageOptions, pixels: UnsafePointer<UInt8>)
typealias ImageOptions = (bounds: CGRect, bytesPerRow: Int, bitsPerComponent: Int)

public struct CGPathIntersection {
    public let path: CGPath
    public let boundingBox: CGRect
    public let image: UIImage?
    
    private var rawImage: RawImage? {
        guard  let img = image, let cgImage = img.cgImage, let pixelData = cgImage.dataProvider?.data,
            let pixels = CFDataGetBytePtr(pixelData) else { return nil }
        let boundingBox = CGRect(origin: .init(x: round(self.boundingBox.origin.x),
                                               y: round(self.boundingBox.origin.y)), size: img.size)
        return ((boundingBox, cgImage.bytesPerRow, cgImage.bitsPerComponent), pixels)
    }
    
    public init(from path: CGPath) {
        self.path = path
        self.boundingBox = path.boundingBoxOfPath
        
        UIGraphicsBeginImageContextWithOptions(boundingBox.size, false, 1)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            self.image = nil
            return
        }
        
        let transparentBlack:CGColor = UIColor.black.cgColor
        context.setStrokeColor(transparentBlack)
        context.setLineWidth(0.45)
        
        context.beginPath()
        var translationToOrigin = CGAffineTransform(translationX: -boundingBox.minX, y: -boundingBox.minY)
        let pathAtOrigin = path.copy(using: &translationToOrigin) ?? path
        context.addPath(pathAtOrigin)
        context.closePath()
        context.drawPath(using: .stroke)
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
    }
    
    //MARK: - Calculate Intersections
    public func intersects(path: CGPathIntersection) -> Bool {
        return self.intersectionPoints(with: path).count > 0
    }
    
    public func intersectionPoints(with other: CGPathIntersection) -> [CGPoint] {
        if case let intersectionRect = self.boundingBox.intersection(other.boundingBox), !intersectionRect.isEmpty,
            let image1Raw = self.rawImage, let image2Raw = other.rawImage {
            var intersectionPixels = [CGPoint]()
            //iterate over intersection of bounding boxes
            for x in Int(intersectionRect.minX) ... Int(intersectionRect.maxX - 1) {
                for y in Int(intersectionRect.minY) ... Int(intersectionRect.maxY - 1) {
                    if image1Raw.pixels.colorAt(x: x, y: y, options: image1Raw.options).alpha > 0.05 &&
                        image2Raw.pixels.colorAt(x: x, y: y, options: image2Raw.options).alpha > 0.05 {
                        intersectionPixels.append(.init(x: x, y: y))
                    }
                }
            }
            return  intersectionPixels.count <= 1 ? intersectionPixels :  intersectionPixels.coalescePoints()
        }
        return []
    }
}

extension CGPath {
    public static func circle(at center: CGPoint, withRadius radius: CGFloat) -> CGPath {
        let bezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        return bezierPath.cgPath
    }
    public static func rect(at rect: CGRect) -> CGPath {
        let bezierPath = UIBezierPath(rect: rect)
        return bezierPath.cgPath
    }
    public func intersects(path: CGPath) -> Bool {
        return self.intersectionPoints(with: path).count > 0
    }
    public func intersectionPoints(with path: CGPath) -> [CGPoint] {
        let pathImage1 = CGPathIntersection(from: self)
        let pathImage2 = CGPathIntersection(from: path)
        return pathImage1.intersectionPoints(with: pathImage2)
    }
}

extension UnsafePointer {
    func colorAt(x: Int, y: Int, options: ImageOptions) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        // rows in memory are always powers of two, leaving empty bytes to pad as necessary.
        let rowWidth = Int(options.bytesPerRow / 4)
        let pixelPointer = ((rowWidth * (y - Int(options.bounds.minY))) + (x - Int(options.bounds.minX))) * 4
        // data[pixelInfo] is a pointer to the first in a series of four UInt8s (r, g, b, a)
        func byte(_ offset: Int) -> CGFloat {
            return CGFloat(self[pixelPointer + offset] as? UInt8 ?? 0) / 255.0
        }
        // buffer in BGRA format
        return (red: byte(2), green: byte(1), blue: byte(0), alpha: byte(3))
    }
    
}

// MARK: - Coalesce Points
extension Array where Element == CGPoint {
    func coalescePoints() -> [CGPoint] {
        var groups = [[Element]]()
        //build groups of nearby pixels
        for point in self {
            var addedToGroup = false
            //search for a nearby group to join
            for i in 0..<groups.count {
                let miniumDistances = groups[i].map{ $0.distance(to: point) }.sorted().first
                if let minimumDistance = miniumDistances, minimumDistance < 4.0 {
                    groups[i].append(point)
                    addedToGroup = true
                    break
                }
            }
            if !addedToGroup {
                groups.append([point])
            }
        }
        //map groups to average values
        return groups.map { group in
            let xAverageSum = group.reduce(0) { $0 + $1.x } / CGFloat(group.count)
            let yAverageSum = group.reduce(0) { $0 + $1.y } / CGFloat(group.count)
            return CGPoint(x: round(xAverageSum), y: round(yAverageSum))
        }
    }
}
extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2))
    }
}
