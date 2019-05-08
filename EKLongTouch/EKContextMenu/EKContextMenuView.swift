//
//  EKContextMenu.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/29/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

class EKContextMenuView: UIView{
    
    private var properties: EKContextMenu!
    
    /// The view that represents the users's touch point
    private var touchPointView:UIView!
    /// The coordinates the the user touched on the screen
    private var touchPoint:CGPoint = .zero
    
    private enum Direction {
        case left,right,middle,up,down
    }
    
    /// Start and end angle of the circle
    private var startEndAngle:(start: CGFloat, end:CGFloat) = (start: 0, end: 0)

    private var itemDistanceToTouchPoint:CGFloat = 10

    var step: CGFloat = -90
    
    public init(touchPoint point:CGPoint ,highlighted view:UIView, properties:EKContextMenu) {
        super.init(frame: UIScreen.main.bounds)
        self.touchPoint = point
        self.properties = properties
        self.configureViews(highlighted: view)
        self.prepareItems()
        self.showItems()
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public func configureViews(highlighted view:UIView){
        let backgroundView:UIView = .build {
            $0.frame = self.frame
            $0.backgroundColor = contextMenuAppearance.backgroundColor
            $0.alpha = contextMenuAppearance.backgroundAlpha
        }
        self.touchPointView = drawTouchPointView()
        self.addSubviews(backgroundView,view,touchPointView)
    }
    private func prepareItems() {
        calcDistanceFromItemToTouchPoint()
        calcDistanceBetweenItems()
        
        for (index,item) in properties.items.enumerated() {
            switch index {
            case 0: item.backgroundColor = .gray
            case 1: item.backgroundColor = .green
            case 2: item.backgroundColor = .yellow
            case 3: item.backgroundColor = .blue
            default: item.backgroundColor = .white
            }
            item.center = touchPoint
            item.angle = startEndAngle.start + CGFloat(index) * step
        }
    }
    public func showItems(){
    
        properties.items.forEach { item in
            addSubview(item)
            UIView.animate(withDuration: item.appearance.duration, delay: item.appearance.delay,
                           usingSpringWithDamping: item.appearance.dampingRatio, initialSpringVelocity: 1,
                           options: [], animations: {
                            item.center = self.calcPointCoordiantes(angle: item.angle)
            }, completion: nil)
        }
    }
    
    func drawTouchPointView() -> UIView {
        return UIView.build{
            $0.frame.size = .init(width: touchPointAppearance.size, height: touchPointAppearance.size)
            $0.center = self.touchPoint
            $0.backgroundColor = .clear
            $0.layer.borderColor = touchPointAppearance.borderColor.cgColor
            $0.borderWidth = touchPointAppearance.borderWidth
            $0.circlerBorder = true
        }
    }
    
}

// MARK: - private methods
extension EKContextMenuView {
    
    /// Calculates the distance from the user's touch location to the menu items
    private func calcDistanceFromItemToTouchPoint() {
        self.itemDistanceToTouchPoint = ((touchPointAppearance.size + itemSize) / 2) + contextMenuAppearance.distanceFromItemToTouchPoint
    }
    private func calcDistanceBetweenItems(){
      let itemsSize = (itemSize * CGFloat(properties.items.count))
      let contentSize = (itemsSize - itemDistanceToTouchPoint) + contextMenuAppearance.itemsDistance
      self.startEndAngle = (start: 0, end: contentSize)
      self.step = self.calcStep()
    }
    private func calcPointCoordiantes(angle: CGFloat) -> CGPoint {
        let x = itemDistanceToTouchPoint * cos(angle.degrees) + touchPoint.x
        let y = itemDistanceToTouchPoint * sin(angle.degrees) + touchPoint.y
        return CGPoint(x: x, y: y)
    }
    
    /**
     Retrieves the incremental lengths between buttons. If the arc length is 360 degrees or more, the increments
     will evenly space out in a full circle. If the arc length is less than 360 degrees, the last button will be
     placed on the endAngle.
     */
    private func calcStep()-> CGFloat{
        var arcLength = startEndAngle.end - startEndAngle.start
        var stepCount = properties.items.count
        if arcLength < 360 {
            stepCount -= 1
        } else if arcLength > 360 {
            arcLength = 360
        }
        return arcLength / CGFloat(stepCount)
    }
    /// Calculates which angle the menu items should appear
    private func anglesForDirection() {
        let directions = calculateDirections()
        print(directions.vertical,directions.horizontal)
        switch directions{
        case (.down,.middle): break
//            negativeQuorterAngle(start: 180)
        case (.middle,.left): break
//            positiveQuorterAngle(start: 135)
        case (.middle,.middle): break

        default: break
        }
    }

    private func calculateDirections() -> (vertical:Direction, horizontal:Direction) {
        var direction:(vertical:Direction, horizontal:Direction) =  (vertical: .middle, horizontal: .middle)
        
        let size:CGFloat = (contextMenuAppearance.distanceFromItemToTouchPoint + touchPointAppearance.size) + itemSize
        let touchPoint = touchPointView.frame.origin
        
        if touchPoint.y + size > UIScreen.main.bounds.height {
            direction.vertical = .up
        }else if touchPoint.x + size > UIScreen.main.bounds.width {
            direction.horizontal = .left
        }else if touchPoint.y - size < 0 {
            direction.vertical = .down
        }else if touchPoint.x - size < 0{
            direction.horizontal = .right
        }
        return direction
    }
}



extension EKContextMenuView {
    var contextMenuAppearance:EKContextAppearance {
        return properties.appearance.contextMenu
    }
    var touchPointAppearance:EKTouchPointAppearance {
        return properties.appearance.touchPoint
    }
    var itemSize: CGFloat {
        guard let size = properties.items.first?.appearance.size else {
            return EKContextMenuItemAppearance().size
        }
        return size
    }
}



