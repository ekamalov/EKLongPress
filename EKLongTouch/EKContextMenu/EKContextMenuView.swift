//
//  EKContextMenu.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/29/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit


// MARK: Protocol

/**
 *  EKContextMenuDelegate
 */
@objc public protocol EKContextMenuDelegate {
    
    /**
     Tells the delegate the circle menu is about to draw a button for a particular index.
     
     - parameter button:     A circle menu button object that circle menu is going to use when drawing the row. Don't change button.tag
     - parameter atIndex:    An button index.
     */
    @objc optional func circleMenu(willDisplay circleButton: EKContextMenuItem, atIndex: Int)
    
    /**
     Tells the delegate that a specified index is about to be selected.
     
     - parameter button:     A selected circle menu button. Don't change button.tag
     - parameter atIndex:    Selected button index
     */
    @objc optional func circleMenu(buttonWillSelected circleButton: EKContextMenuItem, atIndex: Int)
    
    /**
     Tells the delegate that the specified index is now selected.
     
     - parameter button:     A selected circle menu button. Don't change button.tag
     - parameter atIndex:    Selected button index
     */
    @objc optional func circleMenu(buttonDidSelected circleButton: EKContextMenuItem, atIndex: Int)
    
}

protocol EKContextMenuMethods {
    func configureViews()
}

open class EKContextMenuView: UIView, EKContextMenuMethods {
    
    public init(_ highlightedView:UIView, appearance:EKContextMenuAppearance? )  {
        super.init(frame: UIScreen.main.bounds)
        self.addSubview(highlightedView)
        
        
        let defaultAppearance = EKContextMenuAppearance()
        set(view: appearance != nil ? appearance! : defaultAppearance)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(view appearance:EKContextMenuAppearance){
        self.backgroundColor = appearance.backgroundColor
        self.alpha = appearance.backgroundAlpha
    }
    
    func configureViews() {
        
    }
    
    
}
