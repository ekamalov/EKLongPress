//
//  ViewController.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/28/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit
import EKKit
import EKLayout

var mainScreenWidth = UIScreen.main.bounds.width

protocol test {
    var bordorColor:UIColor { get }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var text: UITextField!
    @IBAction func change(_ sender: Any) {
        self.text.isSecureTextEntry = !self.text.isSecureTextEntry
    }
    
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = SPCollectionViewLayout()
        layout.isPaging = true
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: mainScreenWidth-40, height: 67)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.register(CVCell.self, forCellWithReuseIdentifier: CVCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        collectionView.layout {
            $0.left.right.margin(0).top(50).height(250)
        }
      
       
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCell.identifier, for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

class CVCell: UICollectionViewCell {
    static let identifier = "CVCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cons =  EKContextMenu(items: [.init(), .init()], appearance: .init(touchPointApperance: .build{
            $0.borderColor = .black
            $0.size = .init(width: 35, height: 35)
            }))
        
        //        let a:EKContextMenuItemAppearance = .build(block: {
        //            $0.iconsActiveColor = .red
        //        })
        
        
        
        let s = UIView()
        s.backgroundColor = .red
        s.clipsToBounds = true
        addGestureRecognizer(cons.buildGesture())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
