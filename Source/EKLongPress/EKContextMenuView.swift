//
//  EKContextMenu.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/29/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

internal class EKContextMenuView: UIView{
    /// The menu builder
    private var properties: EKContextMenu!
    /// The coordinates the the user touched on the screen
    private var touchPoint:CGPoint = .zero
    /// Start angle of the circle
    private var circleSector:(startAngle:CGFloat,lenght:CGFloat) = (startAngle: 0,lenght: 0)
    ///  If touchpoint more center of the screen then true else false
    private var isMoreMiddle:Bool!
    ///  The available list items, which shows screen
    private var avaiLableItems:[EKItem] = []
    /// The touched item
    internal var activateItem:EKItem?
    /// The distance value from item to touchpoint
    lazy var itemDistanceToTouchPoint: CGFloat = ((touchPointAppearance.size + itemSize) / 2) + ctxAppearance.itemDistFromCenter
    ///  The title label for display touching item title
    private var title:UILabel = UILabel()
    
    // MARK: - Lifecycle
    public init(touchPoint point:CGPoint ,highlighted view:UIView, properties:EKContextMenu) {
        super.init(frame: UIScreen.main.bounds)
        self.touchPoint = point
        self.properties = properties
        self.configureViews(highlighted: view)
        self.prepareItems()
        self.showItems()
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - public methods
extension EKContextMenuView {
    public func showItems(){
        avaiLableItems.forEach { item in
            item.alpha = 1
            UIView.animate(withDuration: item.appearance.duration, delay: item.appearance.delay,
                           usingSpringWithDamping: item.appearance.dampingRatio, initialSpringVelocity: 1,
                           options: [], animations: {
                            item.center = self.calcAnglePoints(angle: item.angle)
            })
        }
    }
}

// MARK: - private methods
extension EKContextMenuView {
    private func prepareItems() {
        self.avaiLableItems = properties.items
        self.isMoreMiddle = touchPoint.x > self.frame.midX
        self.circleSector = calcItemsContentSize()
        self.calculateLabelPosition()
        if properties.debug {
            self.debug()
        }
        if isMoreMiddle {
            avaiLableItems.reversed().enumerated().forEach { addItem(index: $0.offset, item: $0.element) }
        }else {
            avaiLableItems.enumerated().forEach { addItem(index: $0.offset, item: $0.element) }
        }
    }
    
    private func addItem(index:Int ,item:EKItem){
        let step = self.calcStep(step: avaiLableItems.count)
        item.center = touchPoint
        item.angle = circleSector.startAngle + CGFloat(index) * step
        item.alpha = 0
        addSubview(item)
    }
    
    private func configureViews(highlighted view:UIView){
        let backgroundView:UIView = .build {
            $0.frame = self.frame
            $0.backgroundColor = ctxAppearance.backgroundColor
        }
        let touchPointView = drawTouchPointView()
        
        self.addSubviews(backgroundView,view,touchPointView,title)
    }
    
    private func calcItemsContentSize() -> (startAngle:CGFloat,lenght:CGFloat){
        if var availableSector = IntersectionCalculator.init(circleCenter: touchPoint, rect: self.frame, radius: menuRadius).sector {
            while contentSize > availableSector.arcLength {
                self.avaiLableItems = self.avaiLableItems.dropLast()
            }
            switch ctxAppearance.itemAling {
            case .bottom:
                availableSector.start += isMoreMiddle ? marginOfScreen : abs(availableSector.arcLength - contentSize) - marginOfScreen
            case .center:
                availableSector.start += (availableSector.arcLength - contentSize) / 2
            case .top:
                availableSector.start += !isMoreMiddle ? marginOfScreen : (availableSector.arcLength - contentSize) - marginOfScreen
            }
            return (startAngle: availableSector.start,lenght: availableSector.arcLength)
        }
        return (startAngle: 180,lenght: 200)
    }
    
    private func calcAnglePoints(angle: CGFloat,offset:CGFloat = 0) -> CGPoint {
        let x = itemDistanceToTouchPoint * cos(angle.toRadians) + touchPoint.x + offset
        let y = itemDistanceToTouchPoint * sin(angle.toRadians) + touchPoint.y + offset
        return CGPoint(x: x, y: y)
    }
    
    private func calculateLabelPosition(){
        self.title.textColor = ctxAppearance.titleColor
        self.title.font = ctxAppearance.titleFont
        self.title.textAlignment = self.isMoreMiddle ? .left : .right
        self.title.frame.size = .init(width: screen.width - 40, height: ctxAppearance.titleFont.lineHeight)
        if case let y = (touchPoint.y - menuRadius - ctxAppearance.titleDistance), y > ctxAppearance.titleFont.lineHeight {
            self.title.frame.origin = .init(x: 20, y: y - ctxAppearance.titleFont.lineHeight)
        }else {
            self.title.frame.origin = .init(x: 20, y: (touchPoint.y + menuRadius + ctxAppearance.titleDistance))
        }
    }
    
    private func calcStep(step count:Int)-> CGFloat{
        var arcLength = contentSize
        var stepCount = count
        if arcLength < 360 {
            stepCount -= 1
        } else if arcLength > 360 {
            arcLength = 360
        }
        return arcLength / CGFloat(stepCount)
    }
    
    private func drawTouchPointView() -> UIView {
        return UIView.build{
            $0.frame.size = .init(width: touchPointAppearance.size, height: touchPointAppearance.size)
            $0.center = self.touchPoint
            $0.backgroundColor = .clear
            $0.layer.borderColor = touchPointAppearance.borderColor.cgColor
            $0.borderWidth = touchPointAppearance.borderWidth
            $0.circlerBorder = true
        }
    }
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
extension EKContextMenuView {
    internal func longPressMoved(to location:CGPoint){
        if let currentItem = self.activateItem, currentItem.frame.contains(location) {
            if !currentItem.isActive {
                currentItem.isActive = true
                self.title.text = currentItem.title
                let newX = (currentItem.wrapper.center.x + cos(currentItem.angle.toRadians) * currentItem.appearance.hoverOffset)
                let newY = (currentItem.wrapper.center.y + sin(currentItem.angle.toRadians) * currentItem.appearance.hoverOffset)
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
                    currentItem.wrapper.center = .init(x: newX, y: newY)
                })
            }
        } else {
            if let currentItem = self.activateItem, currentItem.isActive{
                currentItem.isActive = false
                self.title.text = nil
                UIView.animate(withDuration: 0.2) {
                    currentItem.wrapper.center = .init(x: currentItem.appearance.size / 2, y:  currentItem.appearance.size / 2)
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

// MARK: - extension variables
extension EKContextMenuView {
    private var ctxAppearance:EKContextAppearance { return properties.appearance.contextMenu }
    
    private var touchPointAppearance:EKTouchPointAppearance { return properties.appearance.touchPoint }
    
    private var marginOfScreen:CGFloat { return 20 }
    
    private var menuRadius:CGFloat { return  itemDistanceToTouchPoint + (itemSize / 2) }
    
    private var itemSize: CGFloat {
        guard let size = avaiLableItems.first?.appearance.size else {
            return EKItemAppearance().size
        }
        return size
    }
    private var contentSize:CGFloat {
        let itemsSize = (itemSize * CGFloat(avaiLableItems.count))
        return (itemsSize - itemDistanceToTouchPoint - (touchPointAppearance.size / 2)) + ctxAppearance.itemsDistance
    }
}


