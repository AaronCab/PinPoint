//
//  BioViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

protocol BioDelegate {
    func bioprotocol(bioText: String)
}

class BioViewController: UIViewController {
    
    var delegate: BioDelegate?
    
    var bioView = BioView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bioView)
        let leftBarItem = UIBarButtonItem(customView: bioView.cancel)
        bioView.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: bioView.save)
        bioView.save.addTarget(self, action: #selector(saveBio), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        hideKeyboardWhenTappedAround()
    }
    
 
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveBio(){
        guard let bio = bioView.bio.text else{
            showAlert(title: "error", message: "problem with converting Bio")
            return
        }
        
        delegate?.bioprotocol(bioText: bio)
        navigationController?.popViewController(animated: true)
    }

}
