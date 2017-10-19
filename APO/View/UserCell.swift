//
//  UserCell.swift
//  APO
//
//  Created by Kyle Hsu on 10/19/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var user: User? {
        didSet {
            nameLabel.text = (user?.fname)! + " " + (user?.lname)!
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
    }
}
