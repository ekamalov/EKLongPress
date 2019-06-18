//
//  EKContextAppearance.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

public struct EKAppearance {
    var touchPoint:EKTouchPointAppearance
    var contextMenu:EKContextAppearance
    
    public init(touchPointApperance: EKTouchPointAppearance = EKTouchPointAppearance(),
                contextMenuApperance: EKContextAppearance = EKContextAppearance()) {
        self.touchPoint = touchPointApperance
        self.contextMenu = contextMenuApperance
    }
}

public struct EKTouchPointAppearance:Builder {
    public init() {}
    
    /// The colour of the touch location view // default white
    var borderColor: UIColor = .white
    
    /// The size of the touch location view // default 45
    var size: CGFloat = 45
    
    /// The size of the touch location view // default value 3
    var borderWidth:CGFloat = 7
}

public struct EKContextAppearance:Builder {
    public init() {}
    
    /// The background's alpha of the view. // default value 0.9
    var backgroundAlpha: CGFloat = 0.9
    
    /// The background's colour of the view // default black
    var backgroundColor: UIColor = .black
    
    var itemsDistance:CGFloat = 20
    
    /// The distance from item to touchPoint view
    var distanceFromItemToTouchPoint:CGFloat = 30
}

public struct EKContextMenuItemAppearance:Builder {
    public init() {}
    /// The items' icons default color
    var iconsDefaultColor:UIColor?
    
    /// The items' icons active color
    var iconsActiveColor:UIColor?
    
    /// The size of the item view // default 45
    var size: CGFloat = 56
    
    /// The background's colour of the view // default black
    var backgroundColor: UIColor = .red

    var dampingRatio:CGFloat = 0.4
    var duration:Double = 1
    var delay:Double = 0.3
}


