//
//  EventDescriptionController.swift
//  APO
//
//  Created by Kyle Hsu on 10/18/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class EventDescriptionController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var event: Event? {
        didSet {
            navigationItem.title = event?.eventName
            textView.text = event?.eventDesc
        }
    }
    
    let textView: UILabel = {
        let textView = UILabel()
        textView.sizeToFit()
        textView.numberOfLines = 0
        return textView
    }()
    
    func lines(label: UILabel) -> Int {
        let textSize = CGSize(width: label.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(label.sizeThatFits(textSize).height))
        return rHeight
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.addSubview(textView)
        cell.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        cell.addConstraintsWithFormat(format: "V:|-8-[v0]", views: textView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: CGFloat(lines(label: textView))*5)
    }
    
}

extension UILabel{
    func requiredHeight() -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:self.frame.width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}

