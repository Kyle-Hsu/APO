//
//  WaitlistCell.swift
//  APO
//
//  Created by Kyle Hsu on 10/22/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit
//
//  SignupCell.swift
//  APO
//
//  Created by Kyle Hsu on 10/19/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class WaitlistCell: BaseCell, UITableViewDataSource, UITableViewDelegate {
    private let cellId = "userCellId"
    
    var count: Int?
    
    var users: [Member]? {
        didSet {
            waitlistCollectionView.reloadData()
        }
    }
    
    let waitlistCollectionView: UITableView = {
        //let layout = UICollectionViewFlowLayout()0
        //let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = users?.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! UserCell
        let user = users?[indexPath.item]
        cell.user = user
        cell.count = (indexPath.item + count!) as NSNumber
        cell.isUserInteractionEnabled = false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    let waitlistLabel: UILabel = {
        let label = UILabel()
        label.text = "Wait List"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        addSubview(waitlistCollectionView)
        addSubview(waitlistLabel)
        waitlistCollectionView.dataSource = self
        waitlistCollectionView.delegate = self
        
        waitlistCollectionView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        addConstraintsWithFormat(format: "V:|[v0(30)]-4-[v1]-16-|", views: waitlistLabel, waitlistCollectionView)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: waitlistCollectionView)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: waitlistLabel)
        
    }
}

