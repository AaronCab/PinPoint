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
    var loggedInUserModel: ProfileOfUser!
    var friendThatRequested: ProfileOfUser!
    var friendsFound = [ProfileOfUser](){
        didSet{
            self.chatView.chatLogTableView.dataSource = self
            self.chatView.chatLogTableView.delegate = self
                self.chatView.chatLogTableView.reloadData()
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatView)

        updateFriend { (profileOfFriends, error) in
            if let friends = profileOfFriends{
                self.friendsFound = friends
            }
            if let error = error{
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
            self.chatView.chatLogTableView.dataSource = self
            self.chatView.chatLogTableView.delegate = self
        
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
        guard let cell = chatView.chatLogTableView.dequeueReusableCell(withIdentifier: "chatLogTableViewCell", for: indexPath) as? ChatLogTableViewCell else{
                return UITableViewCell()
        }
        
        if loggedInUserModel.pendingFriends?.count != 0{
            let profile = friendsFound[indexPath.row]
                cell.friendName.text = profile.displayName
                if profile.coverImageURL != nil{
                    cell.friendImageView.kf.setImage(with: URL(string: (profile.photoURL)!), placeholder: UIImage(named: "pinpointred"))
                }else{
                    cell.friendImageView.image = UIImage(named: "pinpointred")
                }
            cell.noButton.isEnabled = true
            cell.yesButton.isEnabled = true
            cell.blockBotton.isEnabled = true
            cell.blockBotton.isHidden = false
            cell.yesButton.isHidden = false
            cell.noButton.isHidden = false
            cell.noButton.tag = indexPath.row
            cell.yesButton.tag = indexPath.row
            cell.blockBotton.tag = indexPath.row
            cell.yesButton.addTarget(self, action: #selector(acceptedRequest), for: .touchUpInside)
            cell.noButton.addTarget(self, action: #selector(rejectedRequest), for: .touchUpInside)
            cell.blockBotton.addTarget(self, action: #selector(blockedUser), for: .touchUpInside)

        }
        if loggedInUserModel.pendingFriends?.count == 0 || loggedInUserModel.pendingFriends?.count == nil{
            cell.friendName.text = "No Friends Here"
            cell.noButton.isEnabled = false
            cell.yesButton.isEnabled = false
            cell.blockBotton.isEnabled = false
            cell.blockBotton.isHidden = true
            cell.yesButton.isHidden = true
            cell.noButton.isHidden = true
            cell.friendImageView.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}



extension EventsViewController{

    
    func updateFriend(completeion: @escaping ([ProfileOfUser]?, Error?) -> Void){
        var friendFound = [ProfileOfUser]()
        if let user = authService.getCurrentUser(){
            DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey)
                .document(user.uid).addSnapshotListener({ (profile, error) in
                    if let profile = profile?.data(){
                        
                           let profile = ProfileOfUser.init(dict: profile)
                        self.loggedInUserModel = profile
                        
                        for friend in profile.pendingFriends!{
                        
                       self.listener = DBService.firestoreDB
                            .collection(ProfileCollectionKeys.CollectionKey).document(friend)
                        .addSnapshotListener({ (data, error) in
                                if let data = data?.data(){
                                  let singleFriend = ProfileOfUser.init(dict: data)
                                    friendFound.append(singleFriend)
                                    if profile.pendingFriends?.last == friend{
                                        completeion(friendFound, nil)
                                    }
                                }else if let error = error{
                                    print(error)
                                }
                            })
                    }
                    }
                    if let error = error{
                        completeion(nil, error)
                    }
                })
        }
    }
    
    // do a DBService nget document here
    @objc func acceptedRequest(tag: UIButton){
        

            if let user = self.authService.getCurrentUser(){
                let alert = UIAlertController(title: "Accept User", message: "Are you sure you want to accept this user as a friend", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
        let pendingFriend = DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey).document(user.uid)
            
            
            pendingFriend.updateData([
                ProfileCollectionKeys.FriendsKey : FieldValue.arrayUnion([self.loggedInUserModel.pendingFriends![tag.tag]])]) { (error) in
                    if let error = error{
                        self.showAlert(title: "error", message: error.localizedDescription)
                    }else{
                        pendingFriend.updateData([
                            ProfileCollectionKeys.PendingFriends : FieldValue.arrayRemove( [(self.loggedInUserModel.pendingFriends![tag.tag]) as Any])], completion: { (error) in
                                if let error = error{
                                    self.showAlert(title: "Error", message: error.localizedDescription)
                                }else{
                                    self.chatView.chatLogTableView.reloadData()
                                }
                        })
                    }
            }
                 }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            present(alert, animated: true)

        }
       

    }
    
    @objc func rejectedRequest(tag: UIButton){
        
 
            if let user = self.authService.getCurrentUser() {
                let alert = UIAlertController(title: "Reject user request", message: "Are you sure you want to reject this user as a friend", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
        let pendingFriend = DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey).document(user.uid)
        pendingFriend.updateData([
            ProfileCollectionKeys.PendingFriends : FieldValue.arrayRemove( [(self.loggedInUserModel.pendingFriends![tag.tag]) as Any])], completion: { (error) in
                if let error = error{
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }else{
                    self.chatView.chatLogTableView.reloadData()
                }
        })
        }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                present(alert, animated: true)
        }
    }
    
    @objc func blockedUser(tag: UIButton){
        if let user = authService.getCurrentUser(){
            
           let alert = UIAlertController(title: "Blockiung User", message: "Are you sure you want to block this user", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            let pendingFriend = DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey).document(user.uid)
            
            
            pendingFriend.updateData([
                ProfileCollectionKeys.isBlocked : FieldValue.arrayUnion([self.loggedInUserModel.pendingFriends![tag.tag]])]) { (error) in
                    if let error = error{
                        self.showAlert(title: "error", message: error.localizedDescription)
                    }else{
                        pendingFriend.updateData([
                            ProfileCollectionKeys.PendingFriends : FieldValue.arrayRemove( [(self.loggedInUserModel.pendingFriends![tag.tag]) as Any])], completion: { (error) in
                                if let error = error{
                                    self.showAlert(title: "Error", message: error.localizedDescription)
                                }else{
                                    self.chatView.chatLogTableView.reloadData()
 

                                }
                            })
                        }
                }
                            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

    
}
