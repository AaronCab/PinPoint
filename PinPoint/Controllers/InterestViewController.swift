//
//  InterestViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class InterestViewController: UIViewController {
    
    var interestView = RequestsView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(interestView)
    }

}
