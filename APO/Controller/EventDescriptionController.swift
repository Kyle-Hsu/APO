//
//  EventDescriptionController.swift
//  APO
//
//  Created by Kyle Hsu on 10/18/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventDescriptionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var event: Event? {
        didSet {
            navigationItem.title = event?.eventName
            
        }
    }
    
    
    override func viewDidLoad() {
        
    }
}
