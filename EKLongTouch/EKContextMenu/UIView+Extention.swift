//
//  UIView+Extention.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 5/3/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

extension UIView {
    var circlerBorder: Bool {
        get { return  layer.cornerRadius == 0 ? false : true }
        set { layer.cornerRadius = newValue ? bounds.size.width/2 : 0}
    }
    
    var borderWidth: CGFloat{
        get { return layer.borderWidth }
        set{
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func addSubviews(_ views:UIView...){
        views.forEach { addSubview($0) }
    }
}
