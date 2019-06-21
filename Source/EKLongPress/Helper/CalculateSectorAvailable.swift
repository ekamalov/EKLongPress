//
//  Intersection+CGPath.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 6/19/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

struct CalculateSectorAvailable{
    let circleCenter:CGPoint
    let rect:CGRect
    let itemDistanceFromCircleCenter:CGFloat
    
    private func calcPointCoordiantes(angle: CGFloat) -> CGPoint {
        let x = itemDistanceFromCircleCenter * cos(angle.toRadians) + circleCenter.x
        let y = itemDistanceFromCircleCenter * sin(angle.toRadians) + circleCenter.y
        return CGPoint(x: x, y: y)
    }
    var sector: (start: CGFloat, end:CGFloat)? {
        var angles:[CGFloat] = []
        for i in stride(from: 0, to: 359, by: 2) {
            let coordinate = calcPointCoordiantes(angle: CGFloat(i))
            if coordinate.x < 0 || coordinate.x > rect.width {
                angles.append(circleCenter.angleToPoint(to: coordinate))
            }
            if coordinate.y < 0 || coordinate.y > rect.height {
                angles.append(circleCenter.angleToPoint(to: coordinate))
            }
        }
        
        for (index,item) in angles.enumerated() {
            if let previos = angles[safety: index - 1] {
                if abs(previos - item) > 3 {
                    return (start: previos,end:item)
                }
            }
        }
        guard let firstAngle = angles.first, let lastAngle = angles.last else { return nil }
        return (start: lastAngle,end: firstAngle)
    }
}
