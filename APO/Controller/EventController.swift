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
        let layout = UICollectionViewFlowLayout()
        
        //line that fixed the problem
        collectionView? = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(EventDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(EventTimeCell.self, forCellWithReuseIdentifier: eventTimeCellId)
        collectionView?.register(SignupsCell.self, forCellWithReuseIdentifier: signUpsCellId)
        collectionView?.reloadData()
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventTimeCellId, for: indexPath) as! EventTimeCell
            cell.event = event
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: signUpsCellId, for: indexPath) as! SignupsCell
        cell.users = event?.users
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 80)
        }
        let height = CGFloat((event?.users?.count)! * 20) + 20
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! EventDetailHeader
        header.event = event
        header.backgroundColor = UIColor.white
        return header
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class testcell: BaseCell {
    override func setupViews() {
        
    }
}
