//
//  ExtensionHomeController.swift
//  PinPoint
//
//  Created by Jason on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension HomeController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userProfile == nil{
            return 0
        }
        if userProfile.friends![0] == ""{
            return 0
        } else {
            return userProfile.friends!.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friendView.chatLogTableView.dequeueReusableCell(withIdentifier: "chatLogTableViewCell", for: indexPath) as? ChatLogTableViewCell,
            let friends = userProfile.friends else{
                return UITableViewCell()
        }
        
        if friends.count != 0{
            updateFriend(friendID: friends[indexPath.row]) { (profile, error) in
                if let profile = profile{
                    cell.friendName.text = profile.displayName
                    if profile.photoURL != nil{
                        cell.friendImageView.kf.setImage(with: URL(string: (profile.photoURL)!), placeholder: UIImage(named: "pinpointred"))
                    }else{
                        cell.friendImageView.image = UIImage(named: "pinpointred")
                    }
                }
            }
            cell.noButton.isEnabled = false
            cell.yesButton.isEnabled = false
            cell.blockBotton.isEnabled = true
            cell.blockBotton.isHidden = true
            cell.yesButton.isHidden = true
            cell.noButton.isHidden = true
            cell.noButton.tag = indexPath.row
            cell.yesButton.tag = indexPath.row
            cell.blockBotton.tag = indexPath.row
        }else{
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userProfile.friends?.count == 0{
            
        }else{
            DBService.firestoreDB
            .collection(ProfileCollectionKeys.CollectionKey)
            .getDocuments(source: .server, completion: { (data, error) in
                if let data = data{
                    let otherUser = data.documents.map { ProfileOfUser(dict: $0.data()) }
                        .filter(){$0.ProfileId == self.userProfile.friends![indexPath.row]}.first
                    let profileDVC = DetailEventViewController()
                    profileDVC.profileOfUser = otherUser
                    self.navigationController?.pushViewController(profileDVC, animated: true)
                }else if let error = error{
                    print(error)
                }
            })
    }
    }
    
    
    
    
    @objc func pendingFreinds(){
        let friendVC = EventsViewController()
        friendVC.loggedInUserModel = userProfile
        self.navigationController?.pushViewController(friendVC, animated: true)

    }
}

extension HomeController {
    
    func listernerForFriends(complete: (@escaping([ProfileOfUser]?, Error?) -> Void)){
            var friendFound = [ProfileOfUser]()
            if let user = authService.getCurrentUser(){
                DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey)
                    .document(user.uid).addSnapshotListener({ (profile, error) in
                        if let profile = profile?.data(){
                            
                            let profile = ProfileOfUser.init(dict: profile)
                            self.userProfile = profile
                            
                            if profile.friends?.count == 1 && profile.friends?[0] ==  "" {
                                complete(nil, nil)
                                return
                            }
                            
                            for friend in profile.friends!{
                                
                                self.friendListener = DBService.firestoreDB
                                    .collection(ProfileCollectionKeys.CollectionKey).document(friend)
                                    .addSnapshotListener({ (data, error) in
                                        if let data = data?.data(){
                                            let singleFriend = ProfileOfUser.init(dict: data)
                                            friendFound.append(singleFriend)
                                            if profile.pendingFriends?.last == friend{
                                                complete(friendFound, nil)
                                            }
                                        }else if let error = error{
                                            print(error)
                                        }
                                    })
                            }
                        }
                        if let error = error{
                            complete(nil, error)
                        }
                    })
            }
        }
    }

    
    

