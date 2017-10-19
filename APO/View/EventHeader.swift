//
//  EventHeader.swift
//  APO
//
//  Created by Kyle Hsu on 10/18/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventDetailHeader: BaseCell {
    
    weak var labelHeightConstraint: NSLayoutConstraint!
    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.labelHeightConstraint.constant = 0.0
                
            } else {
                self.labelHeightConstraint.constant = 128.0
            }
        }
    }
    
    var event: Event? {
        didSet {
            if let eventDesc = event?.eventDesc {
                descLabel.text = eventDesc
            }
        }
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        addSubview(descLabel)
        self.backgroundColor = UIColor.lightGray
        addConstraintsWithFormat(format: "V:|[v0]|", views: descLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: descLabel)
    }
}
