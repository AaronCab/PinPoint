//
//  IntroViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    var introView = IntroView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(introView)
    }


}
