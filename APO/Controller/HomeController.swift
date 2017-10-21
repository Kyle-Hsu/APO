//
//  ViewController.swift
//  APO
//
//  Created by Kyle Hsu on 10/13/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let name = user?.fname {
            navigationItem.title = "Welcome, " + name + "!"
        }
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.leftBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: -10, vertical: 0), for: UIBarMetrics.default)
        fetchEvents()
        fetchSignups()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        

        collectionView?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        collectionView?.register(EventCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.reloadData()
    }

    
    @objc func handleSignOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    var events: [Event]?
    
    func fetchEvents() {
        ApiService.sharedInstance.fetchEvents { (events: [Event]) in
            self.events = events
            self.collectionView?.reloadData()
        }
    }
    
    var signups: [Signup]?
    
    func fetchSignups() {
        ApiService.sharedInstance.fetchSignups { (signups: [Signup]) in
            self.signups = signups
            self.collectionView?.reloadData()
        }
    }
    
    func showControllerForEvent(event: Event) {
        let layout = UICollectionViewFlowLayout()
        let EventViewController:EventController = EventController(collectionViewLayout: layout)
        
        var members: [Member] = []
        for index in 0...(signups?.count)!-1 {
            if signups![index].eventID == event.eventID {
                members.append((signups?[index].member)!)
            }
        }
        event.members = members
        EventViewController.event = event
        navigationController?.pushViewController(EventViewController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.events![indexPath.item]
        showControllerForEvent(event: event)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! EventCell
        cell.event = events?[indexPath.item]
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

