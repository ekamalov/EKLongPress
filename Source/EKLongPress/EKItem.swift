//
//  EKContextMenuItem.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/29/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

open class EKItem: UIView {
    internal var appearance:EKItemAppearance
    internal var angle:CGFloat = .zero
    internal var title:String
    internal lazy var wrapper = UIView()
    private lazy var icon = UIImageView(frame: .zero)
    
   internal var isActive:Bool = false {
        willSet {
            UIView.animate(withDuration: 0.2) {
                self.icon.tintColor = newValue ? self.appearance.iconColor.activate : self.appearance.iconColor._default
                self.wrapper.backgroundColor = newValue ? self.appearance.buttonColor.activate : self.appearance.buttonColor._default
            }
        }
    }
    
    init() {
        self.appearance = EKItemAppearance()
        self.title = ""
        super.init(frame: .init(origin: .zero, size: .init(width: appearance.size, height: appearance.size)))
        setAppearance()
    }
    
    init(title:String, icon:UIImage, appearance:EKItemAppearance = EKItemAppearance()) {
        self.title = title
        self.appearance = appearance
        super.init(frame: .init(origin: .zero, size: .init(width: appearance.size, height: appearance.size)))
    
        self.wrapper.frame = self.frame
        self.icon.image = icon
        self.icon.frame.size = appearance.iconSize
        self.icon.center = wrapper.center
        self.wrapper.addSubviews(self.icon)
        addSubview(wrapper)
        
        setAppearance()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearance(){
        self.backgroundColor = .clear
        self.isActive = false
        self.wrapper.circlerBorder = true
    }
}
