//
//  EventsViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    var event = [Event](){
        didSet {
            DispatchQueue.main.async {
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
