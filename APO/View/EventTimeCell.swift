//
//  EventTimeCell.swift
//  APO
//
//  Created by Kyle Hsu on 10/17/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventTimeCell: BaseCell {
    var event: Event? {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            timeLabel.text = " " + formatter.string(from: (event?.eventStart)! as Date) + " - " + formatter.string(from: (event?.eventEnd)! as Date)
            formatter.dateFormat = "EEEE, MMMM dd"
            dateLabel.text = formatter.string(from: (event?.eventStart)! as Date)
        }
    }
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setupViews() {
        addSubview(timeLabel)
        addSubview(dateLabel)
        addSubview(typeLabel)
        
        addConstraintsWithFormat(format: "V:|[v0(20)][v1(20)][v2]|", views: dateLabel, timeLabel, typeLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: dateLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: timeLabel)
        
    }
}
