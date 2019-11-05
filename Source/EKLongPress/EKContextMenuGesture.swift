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

final public class EKContextMenuGesture: UILongPressGestureRecognizer {
    // MARK: - Properties
    private var properties: EKContextMenu!
    private var window: UIWindow!
    private var contextView:EKContextMenuView!
    
    // MARK: - Initializers
    internal init(builder:EKContextMenu)  {
        super.init(target: nil, action:nil)
        guard let window = UIApplication.shared.delegate?.window else {
            assertionFailure("Can't access to UIApplication Window")
            return
        }
        self.window     = window
        self.properties = builder
        addTarget(self, action:  #selector(touchAction))
    }
    // MARK: - Actions
    @objc private func touchAction(){
        let location = self.location(in: window)
        switch self.state {
        case .began:    longPressBegan(on: location)
        case .changed:  longPressMoved(to: location)
        default:        longPressEnded()
        }
    }
}

// MARK: - Extensions
extension EKContextMenuGesture {
    /// Trigger the events for when the touch begins
    internal func longPressBegan(on location:CGPoint) {
        showMenu(on: location)
    }
    
    /// Triggers the events for when the touch ends
    internal func longPressEnded() {
        if let item = contextView.activateItem, let selected = properties.selectedItem {
            item.isActive = false
            selected(item.item)
        }
        dismissMenu()
    }
    
    /// Triggers the events for when the touch moves
    internal func longPressMoved(to location:CGPoint) {
        contextView.longPressMoved(to: location)
    }
    
    /// Creates the EKContextMenuView view and adds to the Window
    internal func showMenu(on location:CGPoint){
        guard let view = getHighlightedSnapshot() else { return }
        
        Haptic.impact(style: .medium).impact()
        
        contextView = EKContextMenuView(touchPoint: location,highlighted: view, builder: properties)
        UIView.transition(with: self.window, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.window.addSubview(self.contextView)
        })
    }
    
    /// Removes the EKContextMenuView  view from the Window
    internal func dismissMenu(){
        UIView.transition(with: self.window, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            self.contextView.removeFromSuperview()
        })
        self.contextView = nil
    }
    
    /// Gets a snapshot of the touched highlighted view
    internal func getHighlightedSnapshot() -> UIView? {
        guard   let view = self.view,
            let highlightedView = view.snapshotView(afterScreenUpdates: true),
            let superView = view.superview  else {
                assertionFailure("Can't access to view")
                return nil
        }
        highlightedView.frame = superView.convert(view.frame, to: nil)
        return highlightedView
    }
}
