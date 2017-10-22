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
    
    func fetchEvents(completion: @escaping ([Event]) -> ()) {
        let url = NSURL(string: "http://www.apousc.org/IOS/getEvents.php")
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
                    event.eventID = NSNumber(value: Int((dictionary["ID"] as? String)!)!)
                    
                    if let cap = dictionary["max"] {
                        event.eventCap = NSNumber(value: Int(cap as! String)!)
                    }
                    
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
    
    func fetchSignups(completion: @escaping ([Signup]) -> ()) {
        let url = NSURL(string: "http://www.apousc.org/IOS/getSignups.php")
        let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var signups = [Signup]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let member = Member()
                    member.fname = dictionary["fname"] as? String
                    member.lname = dictionary["lname"] as? String
                    member.username = dictionary["username"] as? String
                    
                    let signup = Signup()
                    signup.member = member;
                    signup.eventID = NSNumber(value: Int((dictionary["eventid"] as? String)!)!)
                    signups.append(signup)
                }
                DispatchQueue.main.async(execute: {
                    completion(signups)
                })
            } catch let jsonError {
                print(jsonError)
            }
            
        })
        task.resume()
    }
    
    func verifyLogin(username: String, password: String, completion: @escaping ([User]) -> ()) {
        let parameters = ["username": username, "password": password]
        
        guard let url = URL(string: "http://apousc.org/IOS/verifyLogin.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var users = [User]()
                for dictionary in json as! [[String: AnyObject]] {
                    if let fname = dictionary["fname"] as? String {
                        let user = User()
                        user.fname = fname
                        user.lname = dictionary["lname"] as? String
                        user.username = dictionary["username"] as? String
                        users.append(user)
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    completion(users)
                })
            } catch let jsonError {
                print(jsonError)
            }
            
            
        }.resume()
    }
    
}
