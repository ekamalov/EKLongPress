//
//  EKContextMenuItem.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/29/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit


open class EKContextMenuItem: UIButton {
    var appearance:EKContextMenuItemAppearance
   
    
    init() {
        self.appearance = EKContextMenuItemAppearance()
        super.init(frame: .init(origin: .zero, size: appearance.size))
        setAppearance()
    }
    
    init(appearance:EKContextMenuItemAppearance) {
        self.appearance = appearance
        super.init(frame: .init(origin: .zero, size: appearance.size))
        setAppearance()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAppearance(){
        self.backgroundColor = appearance.backgroundColor
    }
}
