//
//  EKContextAppearance.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit
import EKBuilder

public struct EKApperance {
    var touchPoint:EKTouchPointApperance
    var contextMenu:EKContextAppearance
    
    public init(touchPointApperance: EKTouchPointApperance = EKTouchPointApperance(),
                contextMenuApperance: EKContextAppearance = EKContextAppearance()) {
        self.touchPoint = touchPointApperance
        self.contextMenu = contextMenuApperance
    }
}

public struct EKTouchPointApperance:EKBuilder {
    public init() {}
    
    /// The colour of the touch location view // default white
    var borderColor: UIColor = .white
    
    /// The size of the touch location view // default 35
    var size: CGSize = .init(width: 35, height: 35)
    
    /// The size of the touch location view // default value 3
    var borderWidth:CGFloat = 5
}

public struct EKContextAppearance:EKBuilder {
    public init() {}
    
    /// The background's alpha of the view. // defaul value 0.9
    var backgroundAlpha: CGFloat = 0.9
    
    /// The background's colour of the view // defaul black
    var backgroundColor: UIColor = .black
    
}


public struct EKContextMenuItemAppearance: EKBuilder {
    public init() {}
    /// The items' icons default colour
    var iconsDefaultColor:UIColor?
    
    /// The items' icons active colour
    var iconsActiveColor:UIColor?
    
    
}


