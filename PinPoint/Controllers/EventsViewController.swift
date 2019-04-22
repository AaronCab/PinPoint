//
//  EventsViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseMessaging
import FirebaseCore
import Firebase
import FirebaseDatabase

class EventsViewController: UIViewController {
    
    var chatView = ChatLogView()
    let ref = Database.database().reference().child("messages")
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatView)
        chatView.chatTextField.delegate = self
    }
  
}


extension EventsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textsend = textField.text{
        let childRef = ref.childByAutoId()
        let textToSend = ["text": textsend]
        childRef.updateChildValues(textToSend)
        }
        return true
    }
}


