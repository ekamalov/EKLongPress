//
//  EKContextAppearance.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit
import EKBuilder



public struct EKContextMenuViewAppearance:EKBuilder {
    public init() {}
    
    /// The Background's alpha of the view. // defaul value 0.9
    var backgroundAlpha: CGFloat = 0.9
    
    /// The Background's colour of the view // defaul black
    var backgroundColor: UIColor = .black
    
    /// The colour of the touch location view
    var touchPointColor: UIColor! = .red
    
    public init(backgroundAlpha: CGFloat = 0.9,
                backgroundColor: UIColor = .black,
                touchPointColor: UIColor = .red) {
        self.backgroundAlpha = backgroundAlpha
        self.backgroundColor = backgroundColor
        self.touchPointColor = touchPointColor
    }
    
}


public struct  EKContextMenuItemAppearance: EKBuilder {
    public init() {}
    /// The items' icons default colour
    var iconsDefaultColor:UIColor?
    
    /// The items' icons active colour
    var iconsActiveColor:UIColor?
    
    
}
