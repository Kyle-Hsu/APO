//
//  SignupCell.swift
//  APO
//
//  Created by Kyle Hsu on 10/19/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class SignupsCell: BaseCell, UITableViewDataSource, UITableViewDelegate {
    private let cellId = "userCellId"
    
    var users: [Member]? {
        didSet {
            signUpsCollectionView.reloadData()
        }
    }
    
    let signUpsCollectionView: UITableView = {
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
        cell.member = user
        cell.count = indexPath.item as NSNumber
        cell.isUserInteractionEnabled = false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Signups"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        addSubview(signUpsCollectionView)
        addSubview(signupLabel)
        signUpsCollectionView.dataSource = self
        signUpsCollectionView.delegate = self
        
        signUpsCollectionView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        addConstraintsWithFormat(format: "V:|-8-[v0(30)]-4-[v1]-16-|", views: signupLabel, signUpsCollectionView)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: signUpsCollectionView)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: signupLabel)
        
    }
}
