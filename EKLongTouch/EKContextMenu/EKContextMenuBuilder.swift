//
//  EKContextMenuBuilder.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 4/5/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

typealias typeal = EKContextMenuBuilder



protocol EKContextMenuBuilderProtocol {
    static func buildGesture()-> EKContextMenuGesture
}



struct EKContextMenuBuilder {
    var appearance:EKContextMenuAppearance?
}


extension EKContextMenuBuilder:EKContextMenuBuilderProtocol {
   static func buildGesture() -> EKContextMenuGesture {
        return EKContextMenuGesture(appearance:EKContextMenuAppearance())
    }
}
