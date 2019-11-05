//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

struct Sector {
    var start:CGFloat
    var end:CGFloat
    var arcLength:CGFloat
}

struct IntersectionCalculator {
    let circleCenter:CGPoint
    let rect:CGRect
    let radius:CGFloat

    private let step:CGFloat = 2.0
    
    internal func pointCoordiante(angle: CGFloat) -> CGPoint {
        let x = radius * cos(angle.toRadians) + circleCenter.x
        let y = radius * sin(angle.toRadians) + circleCenter.y
        return CGPoint(x: x, y: y)
    }
    
    var sector:Sector? {
        var angles:[CGFloat]     = []
        var centralAngle:CGFloat = 0
        let isMoreMiddle       = circleCenter.x > rect.midX
        
        loop(startAngle: isMoreMiddle ? 0 : 180) { angle in
            let coordinate = pointCoordiante(angle: CGFloat(angle))
            if rect.contains(coordinate) {
                angles.append(CGFloat(angle))
                centralAngle += step
            }
        }
        
        guard let startAngle = isMoreMiddle ? angles.last : angles.first,
              let endAngle   = isMoreMiddle ? angles.first : angles.last else { return nil }
//        let arcLength = (.pi * Float(radius) * centralAngle) / 180.0

        return Sector(start: startAngle, end: endAngle, arcLength: centralAngle)
    }
    private func loop(startAngle:Int, _ body: (Int) -> Void) {
        var currentAngle:Int = (startAngle % 2) == 1 ? startAngle + 1 : startAngle
        let finalAngle:Int = currentAngle
        while true {
            currentAngle += 2
            if currentAngle >= 360 {
                currentAngle = 0
            }
            body(currentAngle)
            if finalAngle == currentAngle {
                break
            }
        }
    }
}
