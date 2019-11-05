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

internal class EKContextMenuView: UIView{
    /// The menu builder
    private var builder: EKContextMenu!
    /// The coordinates the  user touched on the screen
    private var touchPoint:CGPoint = .zero
    /// Start angle of the circle
    private var circleSector:Sector!
    /// If touchpoint more center of the screen then true else false
    private var isMoreMiddle:Bool!
    /// The available list items, which shows screen
    private var avaiLableItems:[EKItemView] = []
    /// The touched item
    internal var activateItem:EKItemView?
    /// The distance value from item to touchpoint
    lazy var itemDistanceToTouchPoint: CGFloat = ((preference.menu.touchPoint.size + preference.menu.item.size) / 2) + preference.menu.itemDistFromCenter
    /// The title label for display touching item title
    private var title:UILabel = UILabel()
    
    lazy var menuRadius:CGFloat = { return  itemDistanceToTouchPoint + (preference.menu.item.size / 2) }()
    
    lazy var contentLength:CGFloat = {
        let itemsSize = preference.menu.item.size * CGFloat(avaiLableItems.count)
        let circleArcLenght = (2 * .pi * menuRadius) / 360
        return (itemsSize / circleArcLenght) + (preference.menu.itemsDistance * circleArcLenght)
    }()
        
    private var preference: Preference { return builder.preference }

    // MARK: - Lifecycle
    public init(touchPoint point:CGPoint ,highlighted view:UIView, builder:EKContextMenu) {
        super.init(frame: UIScreen.main.bounds)
        self.touchPoint = point
        self.builder = builder
        self.configureViews(highlighted: view)
        
        self.isMoreMiddle = touchPoint.x > self.frame.midX
        
        #if DEBUG
        if builder.debug { self.debug() }
        #endif
        
        self.prepareItems()
        self.showItems()
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - private methods
extension EKContextMenuView {
    private func configureViews(highlighted view:UIView){
        let backgroundView:UIView = .build {
            $0.frame           = self.frame
            $0.backgroundColor = preference.menu.backgroundColor
        }
        let touchPointCircleView = UIView.build{
            $0.frame.size        = .init(width: preference.menu.touchPoint.size, height: preference.menu.touchPoint.size)
            $0.center            = self.touchPoint
            $0.backgroundColor   = .clear
            $0.layer.borderColor = preference.menu.touchPoint.color.cgColor
            $0.borderWidth       = preference.menu.touchPoint.borderWidth
            $0.circlerBorder     = true
        }
        
        self.addSubviews(backgroundView, view, touchPointCircleView, title)
    }
    
    private func prepareItems() {
        self.avaiLableItems = builder.items.map {
            return EKItemView(size: .init(width: preference.menu.item.size, height: preference.menu.item.size), item: $0)
        }
        self.circleSector = calcItemsContentSize()
        
        if isMoreMiddle {
            avaiLableItems.reversed().enumerated().forEach { addItem(index: $0.offset, item: $0.element) }
        }else {
            avaiLableItems.enumerated().forEach { addItem(index: $0.offset, item: $0.element) }
        }
    }
    
    private func addItem(index:Int ,item:EKItemView){
        let step = contentLength / CGFloat(avaiLableItems.count - 1)
        item.center = touchPoint
        item.angle = CGFloat(circleSector.start) + step * CGFloat(index)
        addSubview(item)
    }
    // Fix me
    private func calcItemsContentSize() -> Sector{
        if var availableSector = IntersectionCalculator(circleCenter: touchPoint, rect: self.frame, radius: menuRadius).sector {
            print("first", availableSector)
            switch builder.aling {
            case .bottom:
                let newAngle = availableSector.arcLength - contentLength - preference.menu.marginOfScreen
                availableSector.start = !isMoreMiddle ?  availableSector.start + newAngle : availableSector.end + preference.menu.marginOfScreen
            case .center:
                if availableSector.arcLength == 360 {
                    availableSector.start = 90 + (availableSector.arcLength - contentLength) / 2
                    break
                }
                if isMoreMiddle {
                    availableSector.start = 108
                }else {
                    availableSector.start += (availableSector.arcLength - contentLength) / 2
                }
            case .top:
                availableSector.start = !isMoreMiddle ? availableSector.start + preference.menu.marginOfScreen : (availableSector.start - contentLength) - preference.menu.marginOfScreen
            }
            print(availableSector)
            return availableSector
        }
        return Sector(start: 180, end: 179, arcLength: 360)
    }
    
    private func calcAnglePoints(angle: CGFloat) -> CGPoint {
        let x = itemDistanceToTouchPoint * cos(angle.toRadians) + touchPoint.x
        let y = itemDistanceToTouchPoint * sin(angle.toRadians) + touchPoint.y
        return CGPoint(x: x, y: y)
    }
    
    private func calculateLabelPosition(){
        self.title.textColor     = preference.menu.titleColor
        self.title.font          = preference.menu.titleFont
        self.title.textAlignment = self.isMoreMiddle ? .left : .right
        self.title.frame.size    = .init(width: screen.width - 40, height: preference.menu.titleFont.lineHeight)
        if case let y = (touchPoint.y - menuRadius - preference.menu.titleDistance), y > preference.menu.titleFont.lineHeight {
            self.title.frame.origin = .init(x: 20, y: y - preference.menu.titleFont.lineHeight)
        }else {
            self.title.frame.origin = .init(x: 20, y: touchPoint.y + menuRadius + preference.menu.titleDistance)
        }
    }
}

extension EKContextMenuView {
    public func showItems(){
        self.calculateLabelPosition()
        avaiLableItems.forEach { view in
            UIView.animate(withDuration: view.item.preference.animation.duration, delay: view.item.preference.animation.delay,
                           usingSpringWithDamping: view.item.preference.animation.dampingRatio, initialSpringVelocity: 1,
                           options: [], animations: {
                            view.center = self.calcAnglePoints(angle: view.angle)
            })
        }
    }
    internal func longPressMoved(to location:CGPoint){
        if let currentItem = self.activateItem, currentItem.frame.contains(location) {
            if !currentItem.isActive {
                currentItem.isActive = true
                self.title.text = currentItem.item.title
                Haptic.impact(style: .light).impact()
                
                let newX = (currentItem.wrapper.center.x + cos(currentItem.angle.toRadians) * currentItem.item.preference.animation.hoverOffset)
                let newY = (currentItem.wrapper.center.y + sin(currentItem.angle.toRadians) * currentItem.item.preference.animation.hoverOffset)
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
                    currentItem.wrapper.center = .init(x: newX, y: newY)
                })
            }
        } else {
            if let currentItem = self.activateItem, currentItem.isActive{
                currentItem.isActive = false
                self.title.text = nil
                UIView.animate(withDuration: 0.2) {
                    currentItem.wrapper.center = .init(x: self.preference.menu.item.size / 2, y:  self.preference.menu.item.size / 2)
                }
            }
            for item in avaiLableItems {
                if item.frame.contains(location){
                    activateItem = item
                    break
                }
            }
        }
    }
}

extension EKContextMenuView {
    private func debug(){
        let size = menuRadius * 2
        let frame:CGRect = .init(x: touchPoint.x - (size / 2 ), y: touchPoint.y - (size / 2 ), width: size, height: size)
        let wrapperCircle:UIView = .build {
            $0.frame = frame
            $0.backgroundColor = .white
            $0.circlerBorder = true
        }
        addSubview(wrapperCircle)
    }
}

