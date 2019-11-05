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
public struct ColotState {
    public let active:UIColor
    public let inactive:UIColor
}

public struct Preference {
    public struct ContextMenu {
        public struct TouchPoint {
            /// Use the color property to change the color of the touch point. By default, uses white with alpha 0.1
            public var color: UIColor = UIColor.white.withAlphaComponent(0.1)
            /// The size of the touch location view // default 44
            public var size: CGFloat = 44
            /// The size of the touch location view // default value 6
            public var borderWidth:CGFloat = 6
        }
        public struct Item {
            public struct Animation {
                public var hoverOffset:CGFloat = 14
                public var dampingRatio:CGFloat = 0.5
                public var duration:Double = 0.8
                public var delay:Double = 1
            }
            public var animation: Animation = Animation()
            
            /// Use the backgroundColor property to change the color of the item background. By default, uses white with alpha 0.1
            public var backgroundColor:ColotState = .init(active: .white,
                                                          inactive: .init(red: 28 / 255, green: 28 / 255, blue: 28 / 255, alpha: 1))
            /// Use the iconColor property to change the color of the icon color. By default, uses white with alpha 0.1
            public var iconColor:ColotState = .init(active: .black, inactive: .white)
            /// Use the iconSize property to change the size of the icon. By default, user width: 24, height: 24
            public var iconSize:CGSize = .init(width: 24, height: 24)
            /// Use the size property to change the size of the item. By default, user 56
            public var size: CGFloat = 56
        }
        
        /// Use the backgroundColor property to change the color of the context menu backgroundColor. By default, uses white with alpha 0.9
        public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.9)
        /// Use the itemsDistance property to change the distance of the items between. By default, uses 15px
        public var itemsDistance:CGFloat = 15
        /// Use the itemDistFromCenter property to change the distance from of the item to touch point. By default, uses 15px
        public var itemDistFromCenter:CGFloat = 34
        /// Use the titleFont property to change the font of the  title font. By default user "Gilroy-SemiBold"  with size 48
        public var titleFont:UIFont = .systemFont(ofSize: 48)
        /// Use the titleColor property to change the color of the title text. By default, uses white with alpha 0.9
        public var titleColor:UIColor = .white
        /// Use the titleDistance property to change the distance from of the item to title text. By default, uses 64px
        public var titleDistance:CGFloat = 64
        /// Use the marginOfScreen property to change tThe indent from the edge of the screen. By default, uses 20px
        public var marginOfScreen:CGFloat = 20
        
        public var touchPoint: TouchPoint = TouchPoint()
        public var item: Item = Item()
        
    }
    public var menu: ContextMenu = ContextMenu()
    public init() {}
}
