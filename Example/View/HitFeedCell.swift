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
        let item:EKContextMenuItem = .init()
        let item2:EKContextMenuItem = .init()
        let item3:EKContextMenuItem = .init()
        let item4:EKContextMenuItem = .init()
        
        let cons =  EKContextMenu(items: [item,item2,item3,item4,item,item2,item3,item4], appearance: .init(touchPointApperance: .build{
            $0.borderColor = .white
            $0.size = 45
            }))
        addGestureRecognizer(cons.buildGesture())
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
