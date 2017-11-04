//
//  EventCell.swift
//  APO
//
//  Created by Kyle Hsu on 10/14/17.
//  Copyright © 2017 Kyle. All rights reserved.
//
import UIKit

class EventCell: BaseCell {
    var event: Event? {
        didSet {
            nameLabel.text = " " + (event?.eventName)!
            
            let formatter = DateFormatter()

            formatter.dateFormat = "h:mm a"
            startLabel.text = " " + formatter.string(from: (event?.eventStart)! as Date)
            endLabel.text = " " + formatter.string(from: (event?.eventEnd)! as Date)
            formatter.dateFormat = "EEE \n MM/dd"
            dateLabel.text = formatter.string(from: (event?.eventStart)! as Date)
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return label
    }()
    
    let endLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return label
    }()
    
    var endLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        
        let x = (frame.width - 50 - 4) / 3
        
        addSubview(nameLabel)
        addSubview(startLabel)
        addSubview(endLabel)
        addSubview(typeLabel)
        addSubview(dateLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0(50)][v1]-2-|", views: dateLabel, nameLabel)
        addConstraintsWithFormat(format: "V:|-2-[v0][v1(20)]-2-|", views: nameLabel, startLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0(50)][v1(\(x))]", views: dateLabel, startLabel)
        
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: dateLabel)
        
        //title
        //top constraint
        addConstraint(NSLayoutConstraint(item: endLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 0))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: endLabel, attribute: .left, relatedBy: .equal, toItem: startLabel, attribute: .right, multiplier: 1, constant: 0))

        //height constraint
        addConstraint(NSLayoutConstraint(item: endLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraintsWithFormat(format: "H:[v0(\(x))]", views: endLabel)

        
        //top constraint
        addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 0))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .left, relatedBy: .equal, toItem: endLabel, attribute: .right, multiplier: 1, constant: 0))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .right, relatedBy: .equal, toItem: nameLabel, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //addConstraintsWithFormat(format: "V:[v0(20)]", views: typeLabel)
    }
}
