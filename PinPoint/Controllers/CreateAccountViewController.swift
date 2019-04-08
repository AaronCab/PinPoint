//
//  CreateAccountViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    var createUserView = CreateUserView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createUserView)
        let leftBarItem = UIBarButtonItem(customView: createUserView.cancel)
        createUserView.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: createUserView.create)
        createUserView.create.addTarget(self, action: #selector(createProfile), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func createProfile(){
        
    }
    
}
