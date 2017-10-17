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
    var eventCap: NSNumber?
}

class User: NSObject {
    var userFName: String?
    var userLName: String?
    var userFamily: String?
}
