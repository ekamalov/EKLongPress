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
    
    public init(touchPoint point:CGPoint ,highlighted view:UIView, properties:EKContextMenu) {
        super.init(frame: UIScreen.main.bounds)
        self.touchPoint = point
        self.properties = properties
        self.configureViews(highlighted: view)
        self.showItems()
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public func configureViews(highlighted view:UIView){
        let backgroundView:UIView = .build {
            $0.frame = self.frame
            $0.backgroundColor = properties.appearance.contextMenu.backgroundColor
            $0.alpha = properties.appearance.contextMenu.backgroundAlpha
        }
        self.touchPointView = drawTouchPointView()
        self.addSubviews(backgroundView,view,touchPointView)
    }
    
    public func showItems(){
        calculateDistanceToItem()
        anglesForDirection()
        
        properties.items.forEach { item in
            item.center = touchPoint
            self.addSubview(item)
            UIView.animate(withDuration: item.appearance.duration, delay: item.appearance.delay,
                           usingSpringWithDamping: item.appearance.dampingRatio, initialSpringVelocity: 1,
                           options: [], animations: {
                item.center = self.calculatePointCoordiantes(item.angle)
            }, completion: nil)
        }
    }
    
    func drawTouchPointView() -> UIView {
        return UIView.build{
            $0.frame.size = properties.appearance.touchPoint.size
            $0.center = self.touchPoint
            $0.backgroundColor = .clear
            $0.layer.borderColor = properties.appearance.touchPoint.borderColor.cgColor
            $0.borderWidth = properties.appearance.touchPoint.borderWidth
            $0.circlerBorder = true
        }
    }
    
}

// MARK: - private methods
extension EKContextMenuView {
    private func negativeQuorterAngle(start angle: CGFloat) {
        for (index,item) in  properties.items.enumerated() {
            item.angle = (angle - CGFloat(45 * index))
        }
    }
    
    private func positiveQuorterAngle(start angle: CGFloat) {
        for (index,item) in  properties.items.enumerated() {
            item.angle = (angle + CGFloat(45 * index))
        }
    }
    private func calculatePointCoordiantes(_ angle: CGFloat) -> CGPoint {
        let x = touchPoint.x + cos(.pi * angle/180) * (itemDistance.x)
        let y = touchPoint.y + sin(.pi * angle/180) * (itemDistance.y)
        return CGPoint(x: x, y: y)
    }
    
    /// Calculates which angle the menu items should appear
    private func anglesForDirection() {
        let directions = calculateDirections()
        switch directions{
        case (.down, .right):
            positiveQuorterAngle(start: 0)
        case (.down, .middle):
            positiveQuorterAngle(start: 90)
        case (.middle, .right):
            positiveQuorterAngle(start: 270)
        case (.down, .left):
            negativeQuorterAngle(start: 180)
        case (.up, .right):
            negativeQuorterAngle(start: 0)
        case (.up, .middle), (.up, .left), (.middle,.middle):
            positiveQuorterAngle(start: 180)
        case (.middle, .left):
            positiveQuorterAngle(start: 135)
        default: break
        }
    }
    
    private func itemSize()-> CGSize {
        guard let size = properties.items.first?.appearance.size else {
            return EKContextMenuItemAppearance().size
        }
        return size
    }
    
    /// Calculates the distance from the user's touch location to the menu items
    private func calculateDistanceToItem() {
        self.itemDistance.x = ((touchPointView.frame.width + itemSize().width) / 2) + distanceToTouchPointView
        self.itemDistance.y = ((touchPointView.frame.height + itemSize().height) / 2) + distanceToTouchPointView
    }
    
    private func calculateDirections() -> (vertical:Direction, horizontal:Direction) {
        var direction:(vertical:Direction, horizontal:Direction) =  (vertical: .middle, horizontal: .middle)
        
        let size:CGFloat = (distanceToTouchPointView + touchPointView.frame.width) + itemSize().width
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

