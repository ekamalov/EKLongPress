//
//  EKContextMenuBuilder.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

public typealias EKContextMenu = EKContextMenuBuilder
public typealias Selected = (_ item:EKItem) -> Void

public enum ItemsAling {
    case top,bottom,center
}

public struct EKContextMenuBuilder {
    var appearance:EKAppearance
    var items:[EKItem]
    var debug:Bool
    internal var selected:Selected?
    public init(items: [EKItem],aling:ItemsAling = .center, appearance: EKAppearance = EKAppearance(), debug:Bool = false) {
        self.items = items
        self.appearance = appearance
        self.appearance.contextMenu.itemAling = aling
        self.debug = debug
    }
    public mutating func selected(handler: @escaping (_ item:EKItem) -> Void) {
        selected = handler
    }
}

extension EKContextMenuBuilder{
    func buildGesture() -> EKContextMenuGesture {
        precondition(items.count > 0, "items is empty")
        return EKContextMenuGesture(builder:self)
    }
}
