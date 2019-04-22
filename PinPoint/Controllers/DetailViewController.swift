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
                detailView.detailImageView.image = UIImage(named: "pinpointred")
            }else{
                detailView.detailImageView.kf.setImage(with: URL(string: (favorite.imageUrl!)), placeholder: UIImage(named: "pinpointred"))
            }
            detailView.detailLabel.text = favorite.name
            detailView.detailTextView.text = favorite.description
            
        }
        if event != nil{
        detailView.detailImageView.kf.indicatorType = .activity
        if event.logo?.original.url == nil{
            detailView.detailImageView.image = UIImage(named: "pinpointred")
        }else{
            detailView.detailImageView.kf.setImage(with: URL(string: (event.logo?.original.url)!), placeholder: UIImage(named: "pinpointred"))
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
                detailView.detailImageView.kf.setImage(with: URL(string: (custom.photoURL.description)), placeholder: UIImage(named: "pinpointred"))
            detailView.detailLabel.text = custom.displayName
            detailView.detailTextView.text = custom.eventDescription
                if profileOfUser.photoURL != nil{
                    detailView.displayUserPic.kf.setImage(with: URL(string: (profileOfUser.photoURL)!), placeholder: UIImage(named: "pinpointred"))
            }
                else{
                    detailView.displayUserPic.image = UIImage(named: "pinpointred")
                }
                detailView.displayUserLabel.text = profileOfUser.displayName
            detailView.messageButton.addTarget(self, action: #selector(messageVC), for: .touchUpInside)
            
    }
    }
    
    @objc func messageVC(){
        let messageView = EventsViewController()
        
    self.navigationController?.pushViewController(messageView, animated: true)
    }
}
