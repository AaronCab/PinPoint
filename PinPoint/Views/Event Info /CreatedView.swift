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
    
    lazy var startTextLabel: UILabel = {
       let startTL = UILabel()
        startTL.text = "Enter Start of Event"
        startTL.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        startTL.font = UIFont.init(name: "futura", size: 18)
        return startTL
    }()
    
    lazy var startText: UIDatePicker = {
        let startTF = UIDatePicker()
        startTF.timeZone = NSTimeZone.local
        return startTF
    }()
    lazy var endText: UIDatePicker = {
        let endTF = UIDatePicker()
         endTF.timeZone = NSTimeZone.local
        return endTF
    }()
    lazy var endTextLabel: UILabel = {
        let endTL = UILabel()
        endTL.text = "Enter End of Event"
        endTL.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        endTL.font = UIFont.init(name: "futura", size: 18)
        return endTL
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
        addSubview(startTextLabel)
        addSubview(endTextLabel)
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
        
        startTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationText.snp.bottom).offset(15)
            make.left.equalTo(35)
        }
        
        startText.snp.makeConstraints { (make) in
            make.top.equalTo(startTextLabel.snp.bottom).offset(15)
            make.height.equalTo(110)
            make.left.equalTo(35)
        }
        
        endTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startText.snp.bottom).offset(15)
            make.left.equalTo(35)
        }
        
        endText.snp.makeConstraints { (make) in
            make.top.equalTo(endTextLabel.snp.bottom).offset(5)
             make.height.equalTo(110)
            make.left.equalTo(35)
        }
    }
    
}
extension CreatedView{


}

