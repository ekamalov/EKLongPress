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
    var borderColor: UIColor = UIColor.white.withAlphaComponent(0.1)
    /// The size of the touch location view // default 45
    var size: CGFloat = 41
    /// The size of the touch location view // default value 6
    var borderWidth:CGFloat = 6
}

public struct EKContextAppearance:Builder {
    public init() {}
    /// The background's colour of the view // default black
    var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.9)
    ///  The distance between the items
    var itemsDistance:CGFloat = 24
    /// The distance from item to touchPoint view
    var itemDistFromCenter:CGFloat = 34
    
    var itemAling:ItemsAling = .center

    ///  The font of the title Label
    var titleFont:UIFont = .systemFont(ofSize: 48)
    /// The color of the title label text color
    var titleColor:UIColor = .white
    /// The distance from context menu size of the  title label
    var titleDistance:CGFloat = 64
}

public struct EKItemAppearance:Builder {
    public init() {}
    ///  The item icon default and activated colors
    var iconColor:ColotState = .init(activate: .black, _default: .white)
    /// The button default and activated colors of the wrapper  view
    var buttonColor:ColotState = .init(activate: .white, _default: .init(red: 28 / 255, green: 28 / 255, blue: 28 / 255, alpha: 1))
    /// The size of the item  // default 56
    var size: CGFloat = 56
    /// The size of the icon
    var iconSize:CGSize = .init(width: 24, height: 24)
    ///  The offset  of hover
    var hoverOffset:CGFloat = 14
    
    var dampingRatio:CGFloat = 0.5
    
    var duration:Double = 0.8
    
    var delay:Double = 1
}


struct ColotState {
    let activate:UIColor
    let _default:UIColor
}
