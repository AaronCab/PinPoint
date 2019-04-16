//
//  CreatedViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreatedViewController: UIViewController {
    var createdEvent = CreatedView()
    var authService = AppDelegate.authservice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createdEvent)
        let leftBarItem = UIBarButtonItem(customView: createdEvent.cancel)
        createdEvent.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: createdEvent.create)
//        createdEvent.create.addTarget(self, action: #selector(createProfile), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        
    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
   


}
