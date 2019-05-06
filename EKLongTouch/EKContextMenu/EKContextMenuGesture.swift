//
//  EKContextMenuGesture.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit
import EKKit

class EKContextMenuGesture: UILongPressGestureRecognizer {
    
    private(set) var properties: EKContextMenu!
    private(set) var window: UIWindow!
    private(set) var contextView:EKContextMenuView!
    
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
        case .changed: break
        case .ended: dismissMenu()
        case .cancelled: dismissMenu()
        default: break
        }
    }
}



extension EKContextMenuGesture {
    /// Trigger the events for when the touch begins
    func longPressBegan(on location:CGPoint) {
        showMenu(on: location)
    }
    /// Triggers the events for when the touch ends
    func longPressEnded() {
    }
    /// Triggers the events for when the touch moves
    func longPressMoved(to location:CGPoint) {
    }
    /// Creates the JonContextMenu view and adds to the Window
    func showMenu(on location:CGPoint){
        guard let view = getHighlightedSnapshot() else { return }
        contextView = EKContextMenuView(touchPoint: location,highlightedView: view, properties: properties)
        
        EKTransition.transit(_with: self.window, 0.3, animations: {
            self.window.addSubview(self.contextView)
        }, options: [.transitionCrossDissolve])
    }
    /// Removes the JonContextMenu view from the Window
    func dismissMenu(){
        EKTransition.transit(_with: self.window, 0.3, animations: {
             self.contextView.removeFromSuperview()
        }, options: [.transitionCrossDissolve])
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
