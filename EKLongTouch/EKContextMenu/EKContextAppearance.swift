//
//  EKContextAppearance.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

public struct EKContextMenuAppearance {
    /// The Background's alpha of the view. // defaul value 0.9
    var backgroundAlpha: CGFloat = 0.9
    
    /// The Background's colour of the view // defaul black
    var backgroundColor: UIColor = .black
    
    /// The colour of the touch location view
    var touchPointColor: UIColor!
    
    public init(backgroundAlpha: CGFloat = 0.9,
                backgroundColor: UIColor = .black,
                touchPointColor: UIColor = .red) {
        self.backgroundAlpha = backgroundAlpha
        self.backgroundColor = backgroundColor
        self.touchPointColor = touchPointColor
    }
    
    
    public init(_ build: (inout EKContextMenuAppearance) -> Void) {
        build(&self)
    }
    
}
