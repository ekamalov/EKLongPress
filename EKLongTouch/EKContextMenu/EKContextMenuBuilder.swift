//
//  EKContextMenuBuilder.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

public typealias EKContextMenu = EKContextMenuBuilder

public struct EKContextMenuBuilder {
    var appearance:EKApperance
    var items:[EKContextMenuItem]
    
    public init(items: [EKContextMenuItem], appearance: EKApperance = EKApperance()) {
        self.items = items
        self.appearance = appearance
    } 
}

extension EKContextMenuBuilder{
    func buildGesture() -> EKContextMenuGesture {
        precondition(items.count > 1, "items is empty")
        return EKContextMenuGesture(builder:self)
    }
}
