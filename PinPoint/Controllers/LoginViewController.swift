//
//  LoginViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginView)
        whatToDoForButtons()

    }
    
    func whatToDoForButtons(){
        loginView.createAccountHere.addTarget(self, action: #selector(createButton), for: .touchUpInside)
        loginView.customEmailLogin.addTarget(self, action: #selector(loginWithExsistingAccount), for: .touchUpInside)
    }
    
    @objc func createButton(){
        let createVC = CreateAccountViewController()
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    @objc func loginWithExsistingAccount(){
        let loginWEVC = LoginWithExistingViewController()
        self.navigationController?.pushViewController(loginWEVC, animated: true)
    }
    
}
