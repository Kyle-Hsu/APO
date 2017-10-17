//
//  ApiService.swift
//  APO
//
//  Created by Kyle Hsu on 10/14/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Event]) -> ()) {
        let url = NSURL(string: "http://www.apousc.org/getEvents.php")
        let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var events = [Event]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let event = Event()
                    event.eventName = dictionary["name"] as? String
                    let eventStart = dictionary["start"] as? String
                    let eventEnd = dictionary["end"] as? String
                    
                    let dateFormatter = DateFormatter()
                    TimeZone.ReferenceType.default = TimeZone(abbreviation: "UTC")!
                    dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
                    
                    event.eventDesc = dictionary["desc"] as? String
                    if let date = dateFormatter.date(from: eventStart!) {
                        event.eventStart = date as NSDate
                    }
                    if let date = dateFormatter.date(from: eventEnd!) {
                        event.eventEnd = date as NSDate
                    }
                    
                    
                    events.append(event)
                }
                DispatchQueue.main.async(execute: {
                    completion(events)
                })
            } catch let jsonError {
                print(jsonError)
            }
            
        })
        task.resume()
    }
    
}
