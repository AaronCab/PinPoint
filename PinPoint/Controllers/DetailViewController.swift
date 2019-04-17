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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(detailView)
        updateDetailView()
    }
    
    func updateDetailView(){
        detailView.detailImageView.kf.indicatorType = .activity
        if event.logo?.original.url == nil{
            detailView.detailImageView.image = UIImage(named: "pinpointred")
        }else{
            detailView.detailImageView.kf.setImage(with: URL(string: (event.logo?.original.url)!), placeholder: UIImage(named: "pinpointred"))
        }
        detailView.detailLabel.text = event.name?.text    }

}
