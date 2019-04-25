//
//  CreatedView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreatedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    lazy var cancel: UIButton = {
        var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
        return button
    }()
    lazy var create: UIButton = {
        var button = UIButton()
        button.setTitle("Create Event", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
        return button
    }()
    lazy var createName: UITextField = {
        let createTF = UITextField()
        createTF.placeholder = "Enter Name of Event"
        createTF.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        createTF.font = UIFont.init(name: "futura", size: 20)
        createTF.textAlignment = .center
        return createTF
    }()
    var createdPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "placeholder-image")
        return imageView
    }()
//    lazy var textView: UITextView = {
//        let textView = UITextView()
//        textView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
//        textView.font = UIFont(name:"futura" , size: 16)
//        textView.text = "Enter Event's Description"
//        textView.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        return textView
//    }()
    
    lazy var eventText: UITextField = {
        let eventText = UITextField()
        eventText.placeholder = "Enter Event's Description"
        eventText.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        eventText.font = UIFont.init(name: "futura", size: 18)
        return eventText
    }()
    lazy var locationText: UITextField = {
        let locationTF = UITextField()
        locationTF.placeholder = "Enter Location of Event"
        locationTF.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        locationTF.font = UIFont.init(name: "futura", size: 18)
        return locationTF
    }()
    lazy var startText: UITextField = {
        let startTF = UITextField()
        startTF.placeholder = "Starts At:"
        startTF.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        startTF.font = UIFont.init(name: "futura", size: 18)
        return startTF
    }()
    lazy var endText: UITextField = {
        let endTF = UITextField()
        endTF.placeholder = "Ends At:"
        endTF.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        endTF.font = UIFont.init(name: "futura", size: 18)
        return endTF
    }()
    var addEventButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-create-25"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    private func commonInit(){
        addSubview(cancel)
        addSubview(create)
        addSubview(createName)
        addSubview(eventText)
        addSubview(createdPicture)
        addSubview(locationText)
        addSubview(startText)
        addSubview(endText)
        createName.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.snp_topMargin).offset(15)
            make.width.equalTo(350)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        createdPicture.snp.makeConstraints { (make) in
            make.top.equalTo(createName.snp.bottom).offset(15)
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.centerX.equalTo(self.snp.centerX)
        }
        eventText.snp.makeConstraints { (make) in
            make.top.equalTo(createdPicture.snp.bottom).offset(20)
            make.left.equalTo(35)
            make.right.equalTo(-35)
        }
       
        locationText.snp.makeConstraints { (make) in
            make.top.equalTo(eventText.snp.bottom).offset(15)
            make.left.equalTo(35)
        }
        startText.snp.makeConstraints { (make) in
            make.top.equalTo(locationText.snp.bottom).offset(15)
            make.left.equalTo(35)
        }
        endText.snp.makeConstraints { (make) in
            make.top.equalTo(startText.snp.bottom).offset(15)
            make.left.equalTo(35)
        }
    }
    
}
extension CreatedView{
    
//        private func imageConstraints(){
//        addSubview(createdPicture)
//        createdPicture.translatesAutoresizingMaskIntoConstraints = false
//        createdPicture.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
//        createdPicture.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
//        createdPicture.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
//        createdPicture.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor).isActive = true
//    }
//    private func labelConstraint(){
//        addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: createdPicture.bottomAnchor, constant: 8).isActive = true
//        label.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: 30).isActive = true
//
//    }
//
//    private func textViewConstraint(){
//        addSubview(textView)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
//        textView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
//        textView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
//        textView.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor).isActive = true
//
//    }

}

