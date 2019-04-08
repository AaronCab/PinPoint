//
//  LoginWithExistingViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase

class LoginWithExistingViewController: UIViewController {
    
    
    var accountExistingView = AccountExistingView()
    var authService = AppDelegate.authservice
    
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
        self.navigationItem.rightBarButtonItem = rightBarItem    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loginWithCreatedAccount(){
            guard let email = accountExistingView.emailToLogin.text,
                let password = accountExistingView.passwordToLogin.text,
                !email.isEmpty,
                !password.isEmpty
                else{
                    showAlert(title: "Error", message: "Incorrect password and/or username")
                    return
            }
            authService.signInExistingAccount(email: email, password: password)
            
    }
    
    
}

extension LoginWithExistingViewController: AuthServiceExistingAccountDelegate{
    func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    func didSignInToExistingAccount(_ authservice: AuthService, user: User) {
        let containVC = ContainerController()
        self.present(containVC, animated: true)
        
    }
    
    
}

extension LoginWithExistingViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
