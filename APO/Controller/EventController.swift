//
//  EventController.swift
//  APO
//
//  Created by Kyle Hsu on 10/15/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let headerId = "headerId"
    
    var event: Event? {
        didSet {
            navigationItem.title = event?.eventName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.backgroundColor = UIColor.red
//        collectionView?.register(EventDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: headerId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! EventDetailHeader
//        header.event = event
//        return header
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 170)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class EventDetailHeader: BaseCell {
    var event: Event? {
        didSet {
            if let eventDesc = event?.eventDesc {
                descLabel.text = eventDesc
            }
        }
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
//        addSubview(descLabel)
        self.backgroundColor = UIColor.yellow
//        addConstraintsWithFormat(format: "V:|[v0]|", views: descLabel)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: descLabel)
    }
}
