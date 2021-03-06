//
//  DetailViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    var detailView = DetailView()
    
    var event: Event!
    var favorite: FavoritesModel!
    var custom: EventCreatedByUser!
    var profileOfUser: ProfileOfUser!
    var authService = AppDelegate.authservice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(detailView)
        updateDetailView()
        
        
    }
    
    
    func updateDetailView(){
        if favorite != nil{
            detailView.detailImageView.kf.indicatorType = .activity
            if favorite.imageUrl == nil{
                detailView.detailImageView.image = UIImage(named: "PinPoint_Logo_Clear")
            }else{
                detailView.detailImageView.kf.setImage(with: URL(string: (favorite.imageUrl!)), placeholder: UIImage(named: "PinPoint_Logo_Clear"))
            }
            detailView.detailLabel.text = favorite.name
            detailView.detailTextView.text = favorite.description
            
        }
        if event != nil{
            detailView.detailImageView.kf.indicatorType = .activity
            if event.logo?.original.url == nil{
                detailView.detailImageView.image = UIImage(named: "PinPoint_Logo_Clear")
            }else{
                detailView.detailImageView.kf.setImage(with: URL(string: (event.logo?.original.url)!), placeholder: UIImage(named: "PinPoint_Logo_Clear"))
            }
            detailView.detailLabel.text = event.name?.text
            detailView.detailTextView.text = event.description?.text
            detailView.displayUserPic.isHidden = true
            detailView.displayUserLabel.isHidden = true
            detailView.messageButton.isEnabled = false
            detailView.messageButton.isHidden = true
            
        }
        if custom != nil{
            detailView.detailImageView.kf.indicatorType = .activity
            detailView.detailImageView.kf.setImage(with: URL(string: (custom.photoURL.description)), placeholder: UIImage(named: "PinPoint_Logo_Clear"))
            detailView.detailLabel.text = custom.displayName
            detailView.detailTextView.text = custom.eventDescription
            if profileOfUser.photoURL != nil{
                detailView.displayUserPic.kf.setImage(with: URL(string: (profileOfUser.photoURL!)), placeholder: UIImage(named: "PinPoint_Logo_Clear"))
                detailView.displayUserPic.backgroundColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
            }
            else{
                detailView.displayUserPic.image = UIImage(named: "PinPoint_Logo_Clear")
                
            }
            detailView.displayUserLabel.text = profileOfUser.displayName
            if custom.personID == authService.getCurrentUser()?.uid{
                detailView.messageButton.isEnabled = false
                detailView.messageButton.isHidden = true

                
            }else{
                detailView.messageButton.isEnabled = true
                detailView.messageButton.isHidden = false
            detailView.messageButton.addTarget(self, action: #selector(addAsAFriend), for: .touchUpInside)
        }
        }
    }
    
    @objc func addAsAFriend(){
      let alertController = UIAlertController(title: nil, message: "Are you sure you want friend this person?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "Sure", style: .default, handler: { (action) in
            if let user = self.authService.getCurrentUser(){
                let pendingFriend = DBService.firestoreDB.collection(ProfileCollectionKeys.CollectionKey).document(self.custom.personID)
                
                pendingFriend.updateData([
                    ProfileCollectionKeys.PendingFriends : FieldValue.arrayUnion([user.uid])]) { (error) in
                        if let error = error{
                            self.showAlert(title: "error", message: error.localizedDescription)
                            
                        }else{
                            self.dismiss(animated: true, completion: nil)
                        }
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertController, animated: true)
    }

}
