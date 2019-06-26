//
//  Intersection+CGPath.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 6/19/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

struct IntersectionCalculator{
    let circleCenter:CGPoint
    let rect:CGRect
    let radius:CGFloat
    internal func pointCoordiante(angle: CGFloat) -> CGPoint {
        let x = radius * cos(angle.toRadians) + circleCenter.x
        let y = radius * sin(angle.toRadians) + circleCenter.y
        return CGPoint(x: x, y: y)
    }
   
    var sector:(start: CGFloat, end:CGFloat,arcLength:CGFloat)? {
        var angles:[CGFloat] = []
        var length:CGFloat = 359
        for i in stride(from: 0, to: 359, by: 2) {
            let coordinate = pointCoordiante(angle: CGFloat(i))
            if coordinate.x < 0 || coordinate.x > rect.width - 0 {
                angles.append(circleCenter.angleToPoint(to: coordinate))
                length -= 2
            }
            if coordinate.y < 0 || coordinate.y > rect.height {
                angles.append(circleCenter.angleToPoint(to: coordinate))
                length -= 2
            }
        }
        for (index,item) in angles.enumerated() {
            if let previos = angles[safety: index - 1] {
                if abs(previos - item) > 3 {
                    return (start: previos,end: item,arcLength: length)
                }
            }
        }
        guard let firstAngle = angles.first, let lastAngle = angles.last else { return nil }
        return (start: lastAngle,end: firstAngle,arcLength: length)
    }
}
