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
    public let preference: Preference.ContextMenu.Item
    // MARK: - Initializers
    public init(title:String, icon:UIImage) {
        self.title = title
        self.icon  = icon
        self.preference = .init()
    }
    
    /// Initializer
    /// - Parameter title: Title of the item
    /// - Parameter icon: Icon of the iten
    /// - Parameter preference: Item appearance
    public init(title: String, icon: UIImage, preference: Preference.ContextMenu.Item) {
        self.title = title
        self.icon  = icon
        self.preference = preference
    }
}

open class EKItemView: UIView {
    internal let item:EKItem
    internal var angle:CGFloat = .zero
    internal var wrapper:UIView
    private var icon:UIImageView
    
    internal var isActive:Bool = false {
        willSet {
            UIView.animate(withDuration: 0.2) {
                self.icon.tintColor          = newValue ? self.item.preference.iconColor.active : self.item.preference.iconColor.inactive
                self.wrapper.backgroundColor = newValue ? self.item.preference.backgroundColor.active : self.item.preference.backgroundColor.inactive
            }
        }
    }
  
    init(size: CGSize, item:EKItem) {
        self.item = item
        self.icon = UIImageView(image: item.icon)
        self.wrapper = .init(frame: .init(origin: .zero, size: size))
        super.init(frame: wrapper.frame)
        
        self.icon.frame.size = item.preference.iconSize
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
