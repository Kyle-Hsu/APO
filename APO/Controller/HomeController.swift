//
//  ViewController.swift
//  APO
//
//  Created by Kyle Hsu on 10/13/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchEvents()
        navigationItem.title = "Upcoming Events"
        collectionView?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        collectionView?.register(EventCell.self, forCellWithReuseIdentifier: "cellId")
        
        
    }

    var events: [Event]?

    func fetchEvents() {
        ApiService.sharedInstance.fetchVideos { (events: [Event]) in
            self.events = events
            self.collectionView?.reloadData()
        }
    }
    
    func showControllerForEvent(event: Event) {
        let layout = UICollectionViewLayout()
        let EventViewController = EventController(collectionViewLayout: layout)
        EventViewController.event = event
    
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(EventViewController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.events![indexPath.item]
        print(event.eventName)
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

