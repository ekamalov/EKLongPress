//
//  EKContextMenuBuilder.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

typealias EKContextMenu = EKContextMenuBuilder

struct EKContextMenuBuilder {
    var appearance:EKContextMenuViewAppearance?
    var items:[EKContextMenuItem]
    
    public init(items: [EKContextMenuItem], appearance: EKContextMenuViewAppearance) {
        self.items = items
        self.appearance = appearance
    } 
}

extension EKContextMenuBuilder{
    func buildGesture() -> EKContextMenuGesture {
        return EKContextMenuGesture(appearance:appearance)
    }
}
