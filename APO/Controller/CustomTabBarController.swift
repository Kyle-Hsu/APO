//
//  CustomTabBarController.swift
//  APO
//
//  Created by Kyle Hsu on 11/5/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var user: User?

    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            //assume user is logged in
            self.tabBar.unselectedItemTintColor = UIColor.lightGray
            self.tabBar.tintColor = UIColor.darkGray
            

            self.tabBar.layer.borderWidth = 0.8
            self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
            
            let layout = UICollectionViewFlowLayout()
            let homeController = HomeController(collectionViewLayout: layout)
            let myEventsController = MyEventsController(collectionViewLayout: layout)
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
                myEventsController.user = user
                let allEventsNavController = UINavigationController(rootViewController: homeController)
                allEventsNavController.tabBarItem.title = "All Events"
                allEventsNavController.tabBarItem.image = UIImage(named: "house")
                
                let myEventsNavController = UINavigationController(rootViewController: myEventsController)
                myEventsNavController.tabBarItem.image = UIImage(named: "profile")
                myEventsNavController.tabBarItem.title = "My Events"
                
                viewControllers = [allEventsNavController, createDummyNavControllerWithTitle(title: "Service", imageName: "service"), createDummyNavControllerWithTitle(title: "Fellowship", imageName: "fellowship"), myEventsNavController]

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
