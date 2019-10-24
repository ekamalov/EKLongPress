//
//  HitFeedHeader.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 6/14/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit
import EKLayout

class HitFeedHeader:UICollectionReusableView {
    static let identifier = "HitFeedHeader"

    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.text = "All Time Hits"
        $0.font = Fonts.GilroyBold.withSize(25)
    }
    lazy var logo = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(title,logo)
        title.layout { $0.bottom(15).left.right.margin(20) }
        logo.layout { $0.top(0).size(width: 66.7%, height: 81.4%).centerX() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
