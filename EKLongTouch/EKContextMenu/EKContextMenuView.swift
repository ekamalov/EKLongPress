//
//  EKContextMenu.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/29/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

class EKContextMenuView: UIView{
    private var distanceToTouchPointView: CGFloat = 20
    
    var properties: EKContextMenu!
    
    /// The view that represents the users's touch point
    var touchPointView:UIView!
    
    private enum Direction {
        case left,right,middle,up,down
    }
    
    public init(touchPoint point:CGPoint ,highlightedView view:UIView, properties:EKContextMenu) {
        super.init(frame: UIScreen.main.bounds)
        
        self.properties = properties
        self.touchPointView = drawTouchPointView(center: point)
        
        self.addSubviews(view,touchPointView)
        self.setAppearance()
        self.showItems()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAppearance(){
        self.backgroundColor = properties.appearance.contextMenu.backgroundColor
        self.alpha = properties.appearance.contextMenu.backgroundAlpha
    }
    
    public func showItems(){
        print(calculateDirections())
        
        properties.items.forEach {
            self.addSubview($0)
        }
    }
    
    func drawTouchPointView(center point:CGPoint) -> UIView {
        return UIView.build{
            $0.frame.size = properties.appearance.touchPoint.size
            $0.center = point
            $0.backgroundColor = .clear
            $0.layer.borderColor = properties.appearance.touchPoint.borderColor.cgColor
            $0.borderWidth = properties.appearance.touchPoint.borderWidth
            $0.circlerBorder = true
        }
    }
    
}

// MARK: - private methods
extension EKContextMenuView {
    private func calculateDirections() -> (vertical:Direction, horizontal:Direction) {
        var direction:(vertical:Direction, horizontal:Direction) =  (vertical: .middle, horizontal: .middle)
        
        let size:CGFloat = (distanceToTouchPointView + touchPointView.frame.width) + (properties.items.first?.appearance.size.width ?? 30)
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

