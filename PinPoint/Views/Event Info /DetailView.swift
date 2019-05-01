//
//  DetailView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class DetailView: UIView {
  
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Name"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.font = UIFont.init(name: "futura", size: 19)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icons8-ask-question-25")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textView.font = UIFont.init(name: "futura", size: 18)
        textView.text = "Key"
        textView.textColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        return textView
    }()
    
    lazy var displayUserPic: CircularImageView = {
        let userPic = CircularImageView()
        userPic.image = UIImage(named: "placeholder-image")
        userPic.contentMode = .scaleAspectFit
        userPic.layer.masksToBounds = true
        return userPic
    }()
    
    lazy var displayUserLabel: UILabel = {
        let displayLabel = UILabel()
        displayLabel.text = "User Name"
        displayLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        displayLabel.font = UIFont.init(name: "futura", size: 14)
        displayLabel.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return displayLabel
    }()
    
    lazy var messageButton: UIButton = {
       let button = UIButton()
       button.setImage(#imageLiteral(resourceName: "icons8-ok-100"), for: .normal)
        button.isEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        self.backgroundColor = .white
        setUpView()
    }
    private func setUpView(){
        self.addSubview(detailLabel)
        self.addSubview(detailImageView)
        self.addSubview(detailTextView)
        self.addSubview(displayUserPic)
        self.addSubview(displayUserLabel)
        self.addSubview(messageButton)

        detailLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.snp_topMargin).offset(15)
            make.width.equalTo(350)
            make.left.equalTo(10)
            make.right.equalTo(-10)
         }                         
        detailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(15)
            make.width.equalTo(350)
            make.height.equalTo(350)
            make.centerX.equalTo(self.snp.centerX)
        }
        detailTextView.snp.makeConstraints { (make) in
            make.top.equalTo(detailImageView.snp.bottom).offset(15)
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.height.equalTo(200)
        }
        displayUserPic.snp.makeConstraints { (make) in
            make.topMargin.equalTo(detailTextView.snp.bottom).offset(25)
            make.width.equalTo(75)
            make.height.equalTo(75)
            make.left.equalTo(50)
        }
        displayUserLabel.snp.makeConstraints { (make) in
            make.left.equalTo(displayUserPic.snp.right).offset(10)
            make.height.equalTo(100)
            make.top.equalTo(detailTextView.snp.bottom)
        }
        messageButton.snp.makeConstraints { (make) in
            make.top.equalTo(detailTextView.snp.bottom)
            make.height.equalTo(100)
            make.left.equalTo(displayUserLabel.snp.right).offset(50)
        }
        
    }
}
