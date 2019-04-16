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
        detailView.image.kf.indicatorType = .activity
        if event.logo?.original.url == nil{
            detailView.image.image = UIImage(named: "pinpointred")
        }else{
            detailView.image.kf.setImage(with: URL(string: (event.logo?.original.url)!), placeholder: UIImage(named: "pinpointred"))
        }
        detailView.label.text = event.name?.text    }

}
