//
//  LoginController.swift
//  APO
//
//  Created by Kyle Hsu on 10/19/17.
//  Copyright © 2017 Kyle. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var loginScreenView: LoginScreenView?
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        loginScreenView = LoginScreenView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        loginScreenView?.loginController = self
        self.view.addSubview(loginScreenView!)
        
        observeKeyboardNotifications()
        hideKeyboard()
    }
    
    var users: [User]?
    
    func finishedLoggingIn(username: String, password: String){
        ApiService.sharedInstance.verifyLogin(username: username, password: password) { (users: [User]) in
            self.users = users
            if users.count != 0 {
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
                let layout = UICollectionViewFlowLayout()
                let homeController = HomeController(collectionViewLayout: layout)
                homeController.user = users[0]
                mainNavigationController.viewControllers = [homeController]
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(users[0].fname, forKey: "fname")
                UserDefaults.standard.set(users[0].lname, forKey: "lname")
                UserDefaults.standard.set(users[0].username, forKey: "username")
                UserDefaults.standard.synchronize()
                self.dismissKeyboard()
                self.dismiss(animated: true, completion: nil)
            }
            else {
                self.loginScreenView?.errorLabel.isHidden = false
            }
        }
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
}
