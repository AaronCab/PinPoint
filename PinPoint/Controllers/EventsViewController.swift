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
    let authService = AppDelegate.authservice
    var listener: ListenerRegistration!
    var loggedInUserModel: ProfileOfUser!{
        didSet{
//            self.chatView.chatLogTableView.reloadData()
            chatView.chatLogTableView.dataSource = self
            chatView.chatLogTableView.delegate = self
        }
    }
    var friendThatRequested: ProfileOfUser!

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatView)
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
        guard let cell = chatView.chatLogTableView.dequeueReusableCell(withIdentifier: "chatLogTableViewCell", for: indexPath) as? ChatLogTableViewCell,
         let pendingFriends = loggedInUserModel.pendingFriends else{
                return UITableViewCell()
        }
        updateFriend(friendID: pendingFriends[indexPath.row]) { (profile, error) in
            if let profile = profile{
                cell.friendName.text = profile.displayName
                if profile.photoURL != nil{
                    cell.friendImageView.kf.setImage(with: URL(string: (profile.photoURL)!), placeholder: UIImage(named: "pinpointred"))
                }else{
                    cell.friendImageView.image = UIImage(named: "pinpointred")
                }
            }
        }
        cell.noButton.tag = indexPath.row
        cell.yesButton.tag = indexPath.row


        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
    
    func updateFriend(friendID: String, completeion: @escaping (ProfileOfUser?, Error?) -> Void){
        var friendFound: ProfileOfUser!
        if let user = authService.getCurrentUser(){
            self.listener = DBService.firestoreDB
                .collection(ProfileCollectionKeys.CollectionKey)
                .addSnapshotListener({ (data, error) in
                    if let data = data{
                        friendFound = data.documents.map { ProfileOfUser(dict: $0.data()) }
                            .filter(){$0.ProfileId == friendID}.first
                        completeion(friendFound, nil)
                    }
                    if let error = error{
                        completeion(nil, error)
                    }
                })
        }
    }
    
    @objc func acceptedRequest(tag: UIButton){
        if let user = authService.getCurrentUser(){
        let pendingFriend = DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey).document(user.uid)
            
            
            pendingFriend.updateData([
                ProfileCollectionKeys.FriendsKey : FieldValue.arrayUnion([loggedInUserModel.friends![tag.tag]])]) { (error) in
                    if let error = error{
                        self.showAlert(title: "error", message: error.localizedDescription)
                    }else{
                        pendingFriend.updateData([
                            ProfileCollectionKeys.PendingFriends : FieldValue.arrayRemove([tag.tag])], completion: { (error) in
                                if let error = error{
                                    self.showAlert(title: "Error", message: error.localizedDescription)
                                }
                        })
                    }
            }
        }
    }
    
    @objc func rejectedRequest(tag: UIButton){
       if let user = authService.getCurrentUser() {
        let pendingFriend = DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey).document(user.uid)
            pendingFriend.updateData([
                ProfileCollectionKeys.PendingFriends : FieldValue.arrayRemove([tag.tag])], completion: { (error) in
                    if let error = error{
                        self.showAlert(title: "Error", message: error.localizedDescription)
                    }
            })
        }
    }
}
