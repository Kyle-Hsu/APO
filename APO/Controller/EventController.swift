//
//  EventController.swift
//  APO
//
//  Created by Kyle Hsu on 10/15/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let eventTimeCellId = "eventTimeCellId"
    private let signUpsCellId = "signUpsCellId"
    private let headerId = "headerId"
    
    
    var event: Event? {
        didSet {
            navigationItem.title = event?.eventName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
        
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register(EventDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(EventTimeCell.self, forCellWithReuseIdentifier: eventTimeCellId)
        collectionView?.register(SignupsCell.self, forCellWithReuseIdentifier: signUpsCellId)
        collectionView?.reloadData()
        
        setupActionBar()
        
    }

    func setupActionBar() {
        //navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]|", views: redView)

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(event?.members?.count == 0) {
            return 0
        }
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: signUpsCellId, for: indexPath) as! SignupsCell
        cell.users = event?.members
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat((event?.members?.count)! * 30) + 30 + 16
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! EventDetailHeader
        header.event = event
        header.navigationController = self.navigationController
        
        header.backgroundColor = UIColor.white
        return header
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class testcell: BaseCell {
    override func setupViews() {
        
    }
}
