//
//  DetailViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView = DetailView()
    
    var event: Event!
    var favorite: FavoritesModel!

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
            
        }else if event != nil{
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
    }

}
