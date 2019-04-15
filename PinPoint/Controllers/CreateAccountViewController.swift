//
//  CreateAccountViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    var createUserView = CreateUserView()
    var authService = AppDelegate.authservice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createUserView)
        let leftBarItem = UIBarButtonItem(customView: createUserView.cancel)
        createUserView.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: createUserView.create)
        createUserView.create.addTarget(self, action: #selector(createProfile), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        authService.authserviceCreateNewAccountDelegate = self
        createUserView.displayName.delegate = self
        createUserView.emailCreatedwith.delegate = self
        createUserView.passwordCreatedWith.delegate = self
        
    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func createProfile(){
        guard let userName = createUserView.displayName.text,
            let email = createUserView.emailCreatedwith.text,
            let password = createUserView.passwordCreatedWith.text
            else{
                showAlert(title: "Error", message: "Create account error")
                return
        }
        if userName.isEmpty &&
        email.isEmpty &&
        password.isEmpty{
            showAlert(title: "Missing Fields", message: "Please fill out all info")

        }else{
        authService.createNewAccount(username: userName, email: email, password: password)
        }

        }

    
}

extension CreateAccountViewController: AuthServiceCreateNewAccountDelegate{
    func didRecieveErrorCreatingAccount(_ authservice: AuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    func didCreateNewAccount(_ authservice: AuthService, pinpointUser: ProfileOfUser) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}

extension CreateAccountViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
