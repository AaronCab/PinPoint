//
//  ChatLogTableViewCell.swift
//  PinPoint
//
//  Created by Jason on 4/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ChatLogTableViewCell: UITableViewCell {
    
    
    let friendName: UILabel = {
        let fn = UILabel()
        fn.text = "Event Name"
        fn.numberOfLines = 2
        fn.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        fn.font = UIFont.init(name: "futura", size: 20)
        return fn
    }()
    
    let friendImageView: UIImageView = {
        let ei = UIImageView()
        ei.image = UIImage(named: "icons8-ask-question-25")
        ei.contentMode = .scaleAspectFill
        ei.layer.cornerRadius = 20
        ei.layer.masksToBounds = true
        return ei
    }()
    
    let yesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(#imageLiteral(resourceName: "icons8-ok-50.png")), for: .normal)
        return button
    }()
    
    let noButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(#imageLiteral(resourceName: "icons8-cancel-50.png")), for: .normal)
        return button
    }()
    
    let blockBotton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(#imageLiteral(resourceName: "icons8-unavailable-filled-50.png")), for: .normal)
        return button
    }()
    
    
    lazy var chatStackView:UIView = {
        let veiw = UIView()
        
        return veiw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "chatLogTableViewCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupCell()
    }
    
    private func setupCell() {
        self.addSubview(chatStackView)
        chatStackView.addSubview(friendImageView)
        chatStackView.addSubview(friendName)
        chatStackView.addSubview(yesButton)
        chatStackView.addSubview(noButton)
        chatStackView.addSubview(blockBotton)
        
        chatStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        friendImageView.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.height.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        friendName.snp.makeConstraints { (make) in
            make.left.equalTo(friendImageView.snp.right).offset(5)
            make.width.equalTo(90)
            make.centerY.equalToSuperview()
        }
        yesButton.snp.makeConstraints { (make) in
            make.right.equalTo(noButton.snp.left).offset(-5)
            make.height.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        noButton.snp.makeConstraints { (make) in
            make.right.equalTo(blockBotton.snp.left).offset(-5)
            make.height.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        blockBotton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.height.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
    }
    
}
