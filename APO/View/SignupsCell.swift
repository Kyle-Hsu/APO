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
    
    var users: [User]? {
        didSet {
            signUpsCollectionView.reloadData()
        }
    }
    
    let signUpsCollectionView: UITableView = {
        //let layout = UICollectionViewFlowLayout()0
        //let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Signups"
        return label
    }()
    
    override func setupViews() {
        addSubview(signUpsCollectionView)
        addSubview(signupLabel)
        signUpsCollectionView.dataSource = self
        signUpsCollectionView.delegate = self
        
        signUpsCollectionView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        addConstraintsWithFormat(format: "V:|[v0(20)][v1]|", views: signupLabel, signUpsCollectionView)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: signUpsCollectionView)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: signupLabel)
        
    }
}