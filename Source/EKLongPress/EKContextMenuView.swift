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
    private var anglePosition:(start: CGFloat, end:CGFloat) = (start: 0, end: 0)
    
    private var itemDistanceToTouchPoint:CGFloat = 10
    
    public init(touchPoint point:CGPoint ,highlighted view:UIView, properties:EKContextMenu) {
        super.init(frame: UIScreen.main.bounds)
        self.touchPoint = point
        self.properties = properties
        self.configureViews(highlighted: view)
        self.prepareItems()
        self.showItems()
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configureViews(highlighted view:UIView){
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
        let startAngle = self.startAngleAtDirection()
        self.anglePosition = calcItemsContentSize(start: startAngle)
        
        let size = itemDistanceToTouchPoint * 2 + itemSize
        
        let frame:CGRect = .init(x: touchPoint.x - (size / 2 ), y: touchPoint.y - (size / 2 ), width: size, height: size)
        let ss:UIView = .build {
            $0.frame = frame
            $0.backgroundColor = .white
            $0.layer.cornerRadius = size / 2
        }
        
        addSubview(ss)
        print(anglePosition)
        
      
        
        if anglePosition.start < 180 {
            for (index,item) in properties.items.enumerated().reversed() {
                addItem(index: index, item: item)
            }
        }else {
            for (index,item) in properties.items.enumerated() {
                addItem(index: index, item: item)
            }
        }
    }
    func addItem(index:Int ,item:EKContextMenuItem){
        let step = self.calcStep(step: properties.items.count)

        item.center = touchPoint
        let angle = anglePosition.start + CGFloat(index) * step
        let endPosition = self.calcPointCoordiantes(angle: angle)
        item.endPosition = endPosition
        
        item.alpha = 0
        addSubview(item)
    }
    public func showItems(){
        
        properties.items.forEach { item in
            item.alpha = 1
            UIView.animate(withDuration: item.appearance.duration, delay: item.appearance.delay,
                           usingSpringWithDamping: item.appearance.dampingRatio, initialSpringVelocity: 1,
                           options: [], animations: {
                            item.center = item.endPosition
                            
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
    private func calcItemsContentSize(start angle:CGFloat) -> (start: CGFloat, end: CGFloat){
        return (start: angle, end: angle + self.contentSize)
    }
    
    /**
     Retrieves the incremental lengths between buttons. If the arc length is 360 degrees or more, the increments
     will evenly space out in a full circle. If the arc length is less than 360 degrees, the last button will be
     placed on the endAngle.
     */
    private func calcStep(step count:Int)-> CGFloat{
        var arcLength = anglePosition.end - anglePosition.start
        var stepCount = count
        if arcLength < 360 {
            stepCount -= 1
        } else if arcLength > 360 {
            arcLength = 360
        }
        return arcLength / CGFloat(stepCount)
    }
    
    
    private func calcPointCoordiantes(angle: CGFloat) -> CGPoint {
        let x = itemDistanceToTouchPoint * cos(angle.toRadians) + touchPoint.x
        let y = itemDistanceToTouchPoint * sin(angle.toRadians) + touchPoint.y
        return CGPoint(x: x, y: y)
    }
    
    /// Calculates which angle the menu items should appear
    private func startAngleAtDirection() -> CGFloat {
        let size = itemDistanceToTouchPoint * 2 + itemSize
        let frame:CGRect = .init(x: touchPoint.x - (size / 2 ), y: touchPoint.y - (size / 2 ), width: size, height: size)
        
        if frame.minX < 15  { // left
            let padding = 195 + abs(frame.minX) + contextMenuAppearance.itemsDistance
            if frame.minY < 35 { // left
                    let padding = 300 + abs(frame.minY) + contextMenuAppearance.itemsDistance
                    return padding
            }
                return padding > 270 ? 270 + contentSizePadding : padding
        }else if (self.frame.width - frame.maxX) < 15 { // right
            let padding = 175 - ((frame.maxX - self.frame.maxX) + contextMenuAppearance.itemsDistance)
            return padding < 90 ? 90 + contentSizePadding : padding
        }
        
        return 180 + contentSizePadding
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
    var contentSize:CGFloat {
        let itemsSize = (itemSize * CGFloat(properties.items.count))
        return (itemsSize - itemDistanceToTouchPoint) + contextMenuAppearance.itemsDistance
    }
    var contentSizePadding: CGFloat {
        return (180 - contentSize) / 2
    }
}



