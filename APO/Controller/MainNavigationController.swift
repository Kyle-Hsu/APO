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
            user.fname = UserDefaults.standard.string(forKey: "fname")
            user.lname = UserDefaults.standard.string(forKey: "lname")
            user.username = UserDefaults.standard.string(forKey: "username")
            homeController.user = user
            
            viewControllers = [homeController]
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




