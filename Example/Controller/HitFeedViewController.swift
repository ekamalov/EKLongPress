//
//  ViewController.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 3/28/19.
//  Copyright © 2019 E K. All rights reserved.
//

import UIKit

var mainScreen = UIScreen.main.bounds
class HitFeedViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: mainScreen.width, height: 90)
        layout.headerReferenceSize = CGSize.init(width: mainScreen.width, height: 183)
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.darkBackground.value
        cv.register(HitFeedCell.self, forCellWithReuseIdentifier: HitFeedCell.identifier)
        cv.register(HitFeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HitFeedHeader.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var items:HitFeeds = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        APIService.fetchPopularPhoto { result in
            switch result{
            case .success(let items): self.items = items
            case .failure(let error): print(error)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.layout {
            $0.top(36).left.right.bottom.margin(0)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HitFeedViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HitFeedCell.identifier, for: indexPath) as! HitFeedCell
        cell.viewController = self
        cell.data = items[indexPath.row]
        cell.addGesture()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: HitFeedHeader.identifier, for: indexPath)
            return header
        }
        fatalError()
    }
}

