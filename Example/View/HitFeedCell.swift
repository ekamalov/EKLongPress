//
//  HitFeedCell.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 6/13/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

class HitFeedCell: UICollectionViewCell {
    static let identifier = "HitFeedCell"
    
    var data:HitFeed! {
        didSet{
            self.image.image = UIImage(named: self.data.preview)
            self.title.text = self.data.title
            self.subTitle.text = self.data.subTitle
        }
    }
    
    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.text = "Test"
        $0.font = Fonts.GilroyBold.withSize(23)
    }
    
    lazy var subTitle:UILabel = .build {
        $0.textColor = Colors.lightText.withAlpha(0.4)
        $0.text = "sub title"
        $0.font = Fonts.GilroySemiBold.withSize(16)
    }
    
    lazy var seperatorView:UIView = .build {
        $0.backgroundColor = Colors.seperatorView.withAlpha(0.08)
    }
    
    lazy var image:UIImageView = UIImageView(frame: .zero)
    
    var viewController:HitFeedViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(title,subTitle,seperatorView,image)
    }
    
    override func layoutSubviews() {
        image.layout {
            $0.left(20).top.bottom.margin(15).width(60)
        }
        seperatorView.layout {
            $0.left.right.margin(20).top(0).height(1)
        }
        title.layout {
            $0.left(of: image, aligned: .right, 15, relation: .equal).top(20).right(10)
        }
        subTitle.layout {
            $0.top(of: title, aligned: .bottom, 4, relation: .equal).right(20)
            $0.left(of: image, aligned: .right, 15, relation: .equal)
        }
        
    }
    func addGesture(){
        let save:EKItem = EKItem.init(title:"Save", icon: #imageLiteral(resourceName: "add"))
        let play:EKItem = EKItem.init(title:"Watch Trailer", icon: #imageLiteral(resourceName: "play"))
        let share:EKItem = EKItem.init(title:"Share", icon: #imageLiteral(resourceName: "share"))
        let more:EKItem = EKItem.init(title:"More", icon: #imageLiteral(resourceName: "more"))
        
        var cons = EKContextMenu(items: [save,play,share,more], aling: .center,
                                 appearance: .init(contextMenuApperance:
                                    .build{
                                        $0.titleFont = Fonts.GilroyBold.withSize(48)
                                    }), debug: false)
        cons.selected = { item in
            print(item)
        }
        
        addGestureRecognizer(cons.buildGesture())
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
