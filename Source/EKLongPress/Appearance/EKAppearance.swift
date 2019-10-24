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

public struct EKTouchPointCircleAppearance {
    public init() {}
    /// The color of the touch location view // default white
    public var color: UIColor = UIColor.white.withAlphaComponent(0.1)
    /// The size of the touch location view // default 45
    public var size: CGFloat = 44
    /// The size of the touch location view // default value 6
    public var borderWidth:CGFloat = 6
}

/// Ctx is Context
public struct EKLongPressAppearance {
    public init() {}
    /// The background's color of the view // default black
    public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.9)
    /// The distance between the items
   public var itemsDistance:CGFloat = 15
    /// The distance from item to touchPoint view
   public var itemDistFromCenter:CGFloat = 34
    /// Font of the title Label
   public var titleFont:UIFont = .systemFont(ofSize: 48)
    /// Color of the title text
   public var titleColor:UIColor = .white
    /// The distance from the context menu item to the title label
    public var titleDistance:CGFloat = 64
    
    public var touchPoint: EKTouchPointCircleAppearance = .init()
    
    /// The size of the item  // default 56
    public var itemSize: CGFloat = 56
}

public struct EKItemAppearance {
    public init() {}
    ///  The item icon default and activated colors
    public var iconColor:ColotState = .init(active: .black, inactive: .white)
    /// The button default and activated colors of the wrapper  view
    public var backgroundColor:ColotState = .init(active: .white,
                                           inactive: .init(red: 28 / 255, green: 28 / 255, blue: 28 / 255, alpha: 1))
    
    /// The size of the icon
    public var iconSize:CGSize = .init(width: 24, height: 24)
    ///  The offset  of hover
    public var hoverOffset:CGFloat = 14
    
    public var dampingRatio:CGFloat = 0.5
    
    public var duration:Double = 0.8
    
    public var delay:Double = 1
}


public struct ColotState {
   public let active:UIColor
   public let inactive:UIColor
}
