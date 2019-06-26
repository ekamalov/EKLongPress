//
//  EKContextMenuGesture.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

class EKContextMenuGesture: UILongPressGestureRecognizer {
    
    private var properties: EKContextMenu!
    private var window: UIWindow!
    private var contextView:EKContextMenuView!
    
    public init(builder:EKContextMenu)  {
        super.init(target: nil, action:nil)
        guard let window = UIApplication.shared.delegate?.window else {
            assertionFailure("Can't access to UIApplication Window")
            return
        }
        self.window = window
        self.properties = builder
        addTarget(self, action:  #selector(touchAction))
    }
    
    @objc private func touchAction(){
        let location = self.location(in: window)
        switch self.state {
        case .began: longPressBegan(on: location)
        case .changed: longPressMoved(to: location)
        default: longPressEnded()
        }
    }
    deinit {
        print("Sdcds")
    }
}

extension EKContextMenuGesture {
    /// Trigger the events for when the touch begins
    func longPressBegan(on location:CGPoint) {
        showMenu(on: location)
    }
    /// Triggers the events for when the touch ends
    func longPressEnded() {
        if let item = contextView.activateItem, let selected = properties.selected {
            item.wrapper.center = .init(x: item.appearance.size / 2, y:  item.appearance.size / 2)
            item.isActive = false
            selected(item)
        }
        dismissMenu()
    }
    
    /// Triggers the events for when the touch moves
    func longPressMoved(to location:CGPoint) {
        contextView.longPressMoved(to: location)
    }
    
    /// Creates the EKContextMenuView view and adds to the Window
    func showMenu(on location:CGPoint){
        guard let view = getHighlightedSnapshot() else { return }
        contextView = EKContextMenuView(touchPoint: location,highlighted: view, properties: properties)
        UIView.transition(with: self.window, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.window.addSubview(self.contextView)
        })
    }
    /// Removes the EKContextMenuView  view from the Window
    func dismissMenu(){
        UIView.transition(with: self.window, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            self.contextView.removeFromSuperview()
        })
        self.contextView = nil
    }
    
    /// Gets a snapshot of the touched highlighted view
    func getHighlightedSnapshot() -> UIView? {
        guard let view = self.view,
            let highlightedView = view.snapshotView(afterScreenUpdates: true),
            let superView = view.superview  else {
                assertionFailure("Can't access to view")
                return nil
        }
        highlightedView.frame = superView.convert(view.frame, to: nil)
        return highlightedView
    }
}
