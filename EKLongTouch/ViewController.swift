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
    
    
    var viewW: UIView  = .build{
        $0.backgroundColor = .red
    }
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero)
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
        
       
//
//        self.view.addSubview(viewW)
//
//
//
//        viewW.layout {
//            $0.all(0)
//        }
//
//        let item:EKContextMenuItem = .init(appearance: .build {$0.backgroundColor = .gray })
//        let item2:EKContextMenuItem = .init(appearance: .build {$0.backgroundColor = .green })
//        let item3:EKContextMenuItem = .init(appearance: .build {$0.backgroundColor = .yellow })
//        let item4:EKContextMenuItem = .init(appearance: .build {$0.backgroundColor = .blue })
//
//        let cons =  EKContextMenu(items: [item,item2,item3,item4], appearance: .init(touchPointApperance: .build{
//            $0.borderColor = .white
//            $0.size = 35
//            }))
//        viewW.addGestureRecognizer(cons.buildGesture())
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCell.identifier, for: indexPath) as! CVCell
        cell.viewController = self
        cell.addGesture()
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

class CVCell: UICollectionViewCell {
    static let identifier = "CVCell"
    var viewController:ViewController!
    override init(frame: CGRect) {
        super.init(frame: frame)
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








