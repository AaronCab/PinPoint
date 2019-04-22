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
    // needs to be renamed
    
    var chatView = ChatLogView()
    let ref = Database.database().reference().child("messages")
    let authService = AppDelegate.authservice
    var listener: ListenerRegistration!
    var loggedInUserModel: ProfileOfUser!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatView)
        chatView.chatLogTableView.dataSource = self
        chatView.chatLogTableView.delegate = self
        updateUser()
    }
  
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loggedInUserModel.pendingFriends!.count == 0{
            return 1
        }else{
            return loggedInUserModel.pendingFriends!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = chatView.chatLogTableView.dequeueReusableCell(withIdentifier: "chatLogTableViewCell", for: indexPath) as? ChatLogTableViewCell else { return UITableViewCell() }
        
        guard let pendingFriends = loggedInUserModel.pendingFriends else{
            cell.textLabel?.text = "No friends request found"
            return UITableViewCell()
        }
        
        cell.textLabel?.text = pendingFriends[indexPath.row]
        
        return cell
    }
    
    
}



extension EventsViewController{
func updateUser(){
    if let user = authService.getCurrentUser(){
    self.listener = DBService.firestoreDB
    .collection(ProfileCollectionKeys.CollectionKey)
    .addSnapshotListener({ (data, error) in
    if let data = data{
    self.loggedInUserModel = data.documents.map { ProfileOfUser(dict: $0.data()) }
    .filter(){$0.ProfileId == user.uid}.first
    }
    })
    }
    }
}
