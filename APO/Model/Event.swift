//
//  Event.swift
//  APO
//
//  Created by Kyle Hsu on 10/14/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class Event: NSObject {
    var eventID: NSNumber?
    var eventName: String?
    var eventDesc: String?
    var eventType: NSNumber?
    var eventStart: NSDate?
    var eventEnd: NSDate?
    var eventLoc: String?
    var eventCap: NSNumber?
    var users: [User]?
}


