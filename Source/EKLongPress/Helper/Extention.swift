//
//  UIView+Extention.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 5/3/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

let screen = UIScreen.main.bounds

extension UIView {
    var circlerBorder: Bool {
        get { return  layer.cornerRadius == 0 ? false : true }
        set { layer.cornerRadius = newValue ? max(bounds.size.width, bounds.size.height) / 2 : 0 }
    }
    
    var borderWidth: CGFloat{
        get { return layer.borderWidth }
        set{
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func addSubviews(_ views:UIView...){
        views.forEach { addSubview($0) }
    }
}

extension CGPoint {
    func angleToPoint(to comparisonPoint: CGPoint) -> CGFloat {
        let origin = CGPoint.init(x: comparisonPoint.x - self.x, y: comparisonPoint.y - self.y)
        let radians = atan2(origin.y, origin.x)
        var bearingDegrees = radians.toDegrees
        while bearingDegrees < 0 {
            bearingDegrees += 360
        }
        return bearingDegrees
    }
}

extension Array {
    public subscript(safety index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

internal extension CGFloat {
    var toRadians: CGFloat {
        return self * (.pi / 180.0)
    }
    var toDegrees: CGFloat {
        return self * CGFloat(180.0 / .pi)
    }
}

// MARK: - Builder, you can look documentation in GitHub(https://github.com/erikkamalov/EKBuilder.git)
public protocol Builder {
    init()
}
extension Builder {
    public static func build(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = Self.self.init()
        try block(&copy)
        return copy
    }
}
extension NSObject: Builder {}

