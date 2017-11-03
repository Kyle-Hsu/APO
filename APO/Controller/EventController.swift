//
//  EventController.swift
//  APO
//
//  Created by Kyle Hsu on 10/15/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let backgroundColor = UIColor.white
    private let eventTimeCellId = "eventTimeCellId"
    private let signUpsCellId = "signUpsCellId"
    private let waitlistCellId = "waitlistCellId"
    private let headerId = "headerId"
    
    
    var event: Event? {
        didSet {
            navigationItem.title = event?.eventName
        }
    }
    
    func fetchSignUps() {
        ApiService.sharedInstance.fetchSignups(eventId: (event?.eventID?.stringValue)!, completion: { (signups: [Member]) in
            self.event?.members = signups
            self.collectionView?.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = backgroundColor
        collectionView?.showsVerticalScrollIndicator = false
        
        fetchSignUps()

        collectionView?.register(EventDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(EventTimeCell.self, forCellWithReuseIdentifier: eventTimeCellId)
        collectionView?.register(SignupsCell.self, forCellWithReuseIdentifier: signUpsCellId)
        collectionView?.register(WaitlistCell.self, forCellWithReuseIdentifier: waitlistCellId)

        setupNavBarButtons()
        collectionView?.reloadData()
    }
    


    private func setupNavBarButtons() {
        let moreImage = UIImage(named: "signup_icon")?.withRenderingMode(.alwaysTemplate)

        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        moreButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [moreButton]
    }
    
    @objc func handleMore() {
        actionLauncher.showActions()
    }
    
    lazy var actionLauncher: ActionLauncher = {
        let launcher = ActionLauncher()
        launcher.eventController = self
        return launcher
    }()
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numMembers = event?.members?.count {
            if(numMembers == 0) {
                return 0
            } else if(((event?.eventCap?.intValue)! == 0) || numMembers <= (event?.eventCap?.intValue)!) {
                return 1
            }
            return 2
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        if let numMembers = event?.members?.count {
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: signUpsCellId, for: indexPath) as! SignupsCell
                cell.backgroundColor = backgroundColor
                var signups: [Member] = []

                if(((event?.eventCap?.intValue)! == 0) || (numMembers <= (event?.eventCap?.intValue)!)) {
                    for index in 0...numMembers-1 {
                        signups.append((event?.members?[index])!)
                    }
                    cell.users = signups
                    return cell
                } else {
                    for index in 0...(event?.eventCap?.intValue)!-1 {
                        signups.append((event?.members?[index])!)
                    }
                    cell.users = signups
                    return cell
                }
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: waitlistCellId, for: indexPath) as! WaitlistCell
                var waitlist: [Member] = []
                for index in (event?.eventCap?.intValue)! ... numMembers-1 {
                    waitlist.append((event?.members?[index])!)
                }
                cell.users = waitlist
                cell.count = (event?.eventCap?.intValue)!
                return cell
            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: signUpsCellId, for: indexPath)
        return cell
    }
    var height: CGFloat?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         if let numMembers = event?.members?.count {
            if collectionView.numberOfItems(inSection: 0) == 1 {
                let height = CGFloat(numMembers * 30) + 30 + 16 + 8
                return CGSize(width: view.frame.width, height: height)
            } else {
                if(indexPath.item == 0) {
                    let height = CGFloat((event?.eventCap?.intValue)! * 30) + 30 + 16 + 8
                    return CGSize(width: view.frame.width, height: height)
                } else {
                    let height = CGFloat((numMembers - (event?.eventCap?.intValue)!) * 30) + 30 + 16 + 8
                    return CGSize(width: view.frame.width, height: height)
                }
            }
        }
        height = 200;
        return CGSize(width: view.frame.width, height: height!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! EventDetailHeader
        header.event = event
        header.navigationController = self.navigationController
        
        header.backgroundColor = backgroundColor
        return header
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

