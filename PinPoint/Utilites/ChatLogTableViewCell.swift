//
//  ChatLogTableViewCell.swift
//  PinPoint
//
//  Created by Jason on 4/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ChatLogTableViewCell: UITableViewCell {
    
    
    let eventName: UILabel = {
        let en = UILabel()
        en.text = "Event Name"
        en.numberOfLines = 2
        en.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        en.font = UIFont.init(name: "futura", size: 16)
        return en
    }()
    
    let eventImageView: UIImageView = {
        let ei = UIImageView()
        ei.image = UIImage(named: "icons8-ask-question-25")
        ei.contentMode = .scaleAspectFill
        ei.layer.cornerRadius = 20
        ei.layer.masksToBounds = true
        return ei
    }()
    
    let yesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Yes"), for: .normal)
        return button
    }()
    
    let noButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "No"), for: .normal)
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
        chatStackView.addSubview(eventImageView)
        chatStackView.addSubview(eventName)
        chatStackView.addSubview(yesButton)
        chatStackView.addSubview(noButton)
        
        chatStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        eventImageView.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.height.width.equalTo(50)
        }
        
        eventName.snp.makeConstraints { (make) in
            make.left.equalTo(eventImageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        yesButton.snp.makeConstraints { (make) in
            make.left.equalTo(eventName.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
    }
    
}
