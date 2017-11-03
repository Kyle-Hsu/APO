//
//  EventHeader.swift
//  APO
//
//  Created by Kyle Hsu on 10/18/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventDetailHeader: BaseCell {
    
    var navigationController: UINavigationController?
    var event: Event? {
        didSet {
            if let eventDesc = event?.eventDesc {
                descLabel.text = eventDesc
            }
            if let eventLoc = event?.eventLoc {
                if eventLoc != "" {
                    locLabel.text = "Location: " + eventLoc
                }
            }
            

            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            timeLabel.text = " " + formatter.string(from: event?.eventStart as! Date) + " - " + formatter.string(from: event?.eventEnd as! Date)
            formatter.dateFormat = "EEEE, MMMM dd"
            dateLabel.text = formatter.string(from: event?.eventStart as! Date)
            
            if let number = event?.eventCap {
                if Int(truncating: number) > 0 {
                    capLabel.text = "Capped at " + String(describing: number) + " people"
                }
            }
        }
    }
    
    @objc func showEventDescriptionController() {
        let layout = UICollectionViewFlowLayout()
        let eventDescriptionController: EventDescriptionController = EventDescriptionController(collectionViewLayout: layout)
        eventDescriptionController.event = event
        self.navigationController?.pushViewController(eventDescriptionController, animated: true)
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.isUserInteractionEnabled = true
        return label
    }()
    
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
    
    let locLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    
    let capLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var height = 60;
    
    override func setupViews() {
        super.setupViews()
        addSubview(descLabel)
        self.backgroundColor = UIColor.lightGray
        addSubview(timeLabel)
        addSubview(dateLabel)
        addSubview(capLabel)
        addSubview(locLabel)
        descLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showEventDescriptionController)))
        
        
        addConstraintsWithFormat(format: "V:|[v0][v1(20)][v2(20)][v3(" + String(describing:height) + ")][v4(20)]|", views: descLabel, dateLabel, timeLabel,locLabel, capLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: dateLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: timeLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: capLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: descLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: locLabel)
    }
}
