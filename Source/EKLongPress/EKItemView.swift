//
//  EKContextMenuItem.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public struct EKItem {
    // MARK: - Attributes
    public let title:String
    public let icon:UIImage
    public let appearance:EKItemAppearance
    // MARK: - Initializers
    public init(title:String, icon:UIImage) {
        self.title = title
        self.icon  = icon
        self.appearance = EKItemAppearance()
    }
    
    public init(title:String, icon:UIImage, appearance:EKItemAppearance) {
        self.title = title
        self.icon  = icon
        self.appearance = appearance
    }
}

open class EKItemView: UIView {
    internal let data:EKItem

    internal var angle:CGFloat = .zero
    internal var wrapper:UIView
    private var icon:UIImageView
    
    internal var isActive:Bool = false {
        willSet {
            UIView.animate(withDuration: 0.2) {
                self.icon.tintColor          = newValue ? self.data.appearance.iconColor.active : self.data.appearance.iconColor.inactive
                self.wrapper.backgroundColor = newValue ? self.data.appearance.backgroundColor.active : self.data.appearance.backgroundColor.inactive
            }
        }
    }
  
    init(size: CGSize, item:EKItem) {
        self.data = item
        self.icon = UIImageView(image: item.icon)
        self.wrapper = .init(frame: .init(origin: .zero, size: size))
        super.init(frame: wrapper.frame)
        
        self.icon.frame.size = item.appearance.iconSize
        self.icon.center     = wrapper.center
        self.wrapper.addSubviews(self.icon)
        addSubview(wrapper)
        
        configuration()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration(){
        self.backgroundColor = .clear
        self.isActive = false
        self.wrapper.circlerBorder = true
    }
}
