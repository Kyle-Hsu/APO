//
//  MainNavigationController.swift
//  APO
//
//  Created by Kyle Hsu on 10/20/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            //assume user is logged in
            let layout = UICollectionViewFlowLayout()
            let homeController = HomeController(collectionViewLayout: layout)
            let user = User()
            if let fname = UserDefaults.standard.string(forKey: "fname"),
                let lname = UserDefaults.standard.string(forKey: "lname"),
                let username = UserDefaults.standard.string(forKey: "username"){
                user.fname = fname
                user.lname = lname
                user.username = username
                
                if let fam = UserDefaults.standard.string(forKey: "family") {
                    user.family = Int(fam)! as NSNumber;
                }
                
                homeController.user = user
                
                viewControllers = [homeController]
            } else {
                perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
            }
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")  
    }

    @objc func showLoginController() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: {
        })
    }
}




