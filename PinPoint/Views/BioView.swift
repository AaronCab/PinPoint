//
//  BioView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class BioView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var bio: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 15
        textView.font = UIFont.init(name: "futura", size: 14)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return textView
    }()
    
    lazy var cancel: UIButton = {
        var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    
    lazy var save: UIButton = {
        var button = UIButton()
        button.setTitle("Save Bio", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    
    
    func commonInit(){
        bioConstrant()
        addSubview(cancel)
        addSubview(save)
    }
    
    
    private func bioConstrant(){
        addSubview(bio)
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        bio.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        bio.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        bio.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor).isActive = true
        }

}
