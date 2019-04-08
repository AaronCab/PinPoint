//
//  LoginWithExistingViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class LoginWithExistingViewController: UIViewController {
    
    var accountExistingView = AccountExistingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(accountExistingView)
        let leftBarItem = UIBarButtonItem(customView: accountExistingView.cancel)
        accountExistingView.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: accountExistingView.login)
        accountExistingView.login.addTarget(self, action: #selector(loginWithCreatedAccount), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loginWithCreatedAccount(){
        //userlogin delegate goes here
    }
    
    
}
