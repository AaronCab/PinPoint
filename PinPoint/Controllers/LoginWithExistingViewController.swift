//
//  LoginWithExistingViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase

protocol loggedInSuccess {
    func loggedIn(bool: Bool)
}

class LoginWithExistingViewController: UIViewController {
    
    
    var accountExistingView = AccountExistingView()
    var authService = AppDelegate.authservice
    var delegate: loggedInSuccess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadLayout()
    }
    
    func viewDidLoadLayout(){
        view.addSubview(accountExistingView)
        
        let leftBarItem = UIBarButtonItem(customView: accountExistingView.cancel)
        accountExistingView.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: accountExistingView.login)
        accountExistingView.login.addTarget(self, action: #selector(loginWithCreatedAccount), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        accountExistingView.emailToLogin.delegate = self
        accountExistingView.passwordToLogin.delegate = self
        authService.authserviceExistingAccountDelegate = self
        hideKeyboardWhenTappedAround()
        
    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loginWithCreatedAccount(){
        guard let email = accountExistingView.emailToLogin.text,
            let password = accountExistingView.passwordToLogin.text
            else{
                showAlert(title: "Error", message: "Error logging in")
                return
        }
        if email.isEmpty && password.isEmpty{
            showAlert(title: "Error", message: " Incorrect username or password")
        }else{
            authService.signInExistingAccount(email: email, password: password)
        }
        
    }
    
    
}

extension LoginWithExistingViewController: AuthServiceExistingAccountDelegate{
    func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
        delegate?.loggedIn(bool: false)
    }
    
    func didSignInToExistingAccount(_ authservice: AuthService, user: User) {
        delegate?.loggedIn(bool: true)
        
        if let homeController = (parent as? UINavigationController)?.viewControllers.first as? HomeController {
            homeController.loginView.removeFromSuperview()
            homeController.reloadInputViews()
            navigationController?.popViewController(animated: true)
            homeController.profilePageOn()
        }        
    }
    
    
}

extension LoginWithExistingViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
