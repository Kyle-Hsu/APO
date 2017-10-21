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
    var user: Member? {
        didSet {
            nameLabel.text = (user?.fname)! + " " + (user?.lname)!
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var count: NSNumber? {
        didSet {
            if let number = count {
                numberLabel.text = String(describing: (Int(truncating: number) + 1))
            }
        }
    }
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(numberLabel)
        addConstraintsWithFormat(format: "H:|[v0(30)][v1]|", views: numberLabel,nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: numberLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
    }
}
