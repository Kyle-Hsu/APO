//
//  ActionLauncher.swift
//  APO
//
//  Created by Kyle Hsu on 10/22/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class Action: NSObject {
    let name: ActionName
    let imageName: String
    
    init(name: ActionName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum ActionName: String {
    case Cancel = "Cancel & Dismiss"
    case SignUp = "Sign up for event"
    case Delete = "Remove signup"
}


class ActionLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let actions: [Action] = {
        return[Action(name: .SignUp, imageName: "signup_icon"), Action(name: .Delete, imageName: "remove_icon"), Action(name: .Cancel, imageName: "cancel")]
    }()
    
    var eventController: EventController?
    
    func showActions() {
        //show menu
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(actions.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    @objc func handleDismiss(action: Action) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if let window = UIApplication.shared.keyWindow {
                self.blackView.alpha = 0
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            if action.name != .Cancel {
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ActionCell
        
        let action = actions[indexPath.item]
        cell.action = action
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let action = self.actions[indexPath.item]
        handleDismiss(action: action)
        
        if(indexPath.item == 0) {
            handleSignup()
            
        } else if(indexPath.item == 1) {
            handleRemove()
        }
        
        
    }
    

    private func handleSignup() {
        let date = Date()
        let timezoneDate = Calendar.current.date(byAdding: .hour, value: -7, to: date)
        if let eventDate = self.eventController?.event?.eventStart {
            let cutoffDate = Calendar.current.date(byAdding: .day, value: 0, to: eventDate as Date)
            if(cutoffDate! < timezoneDate!) {
                let alert = UIAlertController(title: nil, message: "The event already started!\n Please contact the respective officer!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.eventController?.present(alert, animated: true, completion: nil)
            } else {
                if (eventController?.event?.eventType == 10 && UserDefaults.standard.string(forKey: "family") != "0") {
                    let alert = UIAlertController(title: nil, message: "This is an Alpha Fam event, you are not an Alpha!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.eventController?.present(alert, animated: true, completion: nil)
                    
                } else if (eventController?.event?.eventType == 11 && UserDefaults.standard.string(forKey: "family") != "1") {
                    let alert = UIAlertController(title: nil, message: "This is a Phi Fam event, you are not a Phi!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.eventController?.present(alert, animated: true, completion: nil)
                    
                } else if (eventController?.event?.eventType == 12 && UserDefaults.standard.string(forKey: "family") != "2") {
                    let alert = UIAlertController(title: nil, message: "This is an Omega Fam event, you are not an Omega!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.eventController?.present(alert, animated: true, completion: nil)
                    
                } else {
                    if let username = UserDefaults.standard.string(forKey: "username"){
                        ApiService.sharedInstance.requestSignup(username: username,
                                                                eventId: (self.eventController?.event?.eventID?.stringValue)!,
                                                                completion: {
                                                                    self.eventController?.fetchSignUps()
                        })
                    }
                }
            }
        }
    }
    
    private func handleRemove() {
        let date = Date()
        let timezoneDate = Calendar.current.date(byAdding: .hour, value: -7, to: date)
        if let eventDate = self.eventController?.event?.eventStart {
            let cutoffDate = Calendar.current.date(byAdding: .day, value: -1, to: eventDate as Date)
            
            if(cutoffDate! < timezoneDate!) {
                let alert = UIAlertController(title: nil, message: "It is too late to unsign up.\n Please email the respective officer!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.eventController?.present(alert, animated: true, completion: nil)
            } else {
                if let username = UserDefaults.standard.string(forKey: "username"){
                    ApiService.sharedInstance.removeSignup(username: username,
                                                           eventId: (self.eventController?.event?.eventID?.stringValue)!,
                                                           completion: {
                                                            self.eventController?.fetchSignUps()
                    })
                }
                
            }
        }
    }
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ActionCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

