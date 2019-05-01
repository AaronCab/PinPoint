//
//  CreateAccountViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase
protocol createdAccount {
    func createdAccount(bool: Bool)
}

class CreateAccountViewController: UIViewController {
    
    var createUserView = CreateUserView()
    var authService = AppDelegate.authservice
    var delegate: createdAccount?
    
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
        hideKeyboardWhenTappedAround()
        
    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func createProfile(){
        self.navigationItem.rightBarButtonItem?.isEnabled = false
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
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            
        }else{
            authService.createNewAccount(username: userName, email: email, password: password)
        }
    }
    
    
}

extension CreateAccountViewController: AuthServiceCreateNewAccountDelegate{
    func didRecieveErrorCreatingAccount(_ authservice: AuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
        delegate?.createdAccount(bool: false)
    }
    
    func didCreateNewAccount(_ authservice: AuthService, pinpointUser: ProfileOfUser) {
        delegate?.createdAccount(bool: true)
        if let homeController = (parent as? UINavigationController)?.viewControllers.first as? HomeController {
            homeController.loginView.removeFromSuperview()
            homeController.reloadInputViews()
            navigationController?.popViewController(animated: true)
            homeController.profilePageOn()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension CreateAccountViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
