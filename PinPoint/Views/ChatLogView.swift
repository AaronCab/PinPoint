//
//  ChatLogView.swift
//  PinPoint
//
//  Created by Jason on 4/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ChatLogView: UIView {
    
    public lazy var chatTextField: UITextField = {
     let textField = UITextField()
        textField.backgroundColor = .red
        textField.placeholder = "Enter message"
        return textField
    }()

    public lazy var chatLogTableView: UITableView = {
        let vtv = UITableView()
        vtv.backgroundColor = .white
        return vtv
    }()
    
    public var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "friends").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    var number: UILabel = {
        let button = UILabel()
        button.backgroundColor = .red
        button.textColor = .white
        button.text = "0"
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
    
    private func commonInit() {
        backgroundColor = .white
        self.chatLogTableView.register(ChatLogTableViewCell.self, forCellReuseIdentifier: "chatLogTableViewCell")
         setupTableView()
     settingsButtonConstraint()
//        numberLayout()
//        
    }
    
    private func setupTableView() {
        addSubview(chatLogTableView)
        chatLogTableView.translatesAutoresizingMaskIntoConstraints = false
        chatLogTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        chatLogTableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        chatLogTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        chatLogTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        chatLogTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func settingsButtonConstraint() {
        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([settingsButton.heightAnchor.constraint(equalToConstant: 40), settingsButton.widthAnchor.constraint(equalToConstant: 45)])
    }
    
//    private func numberLayout(){
//        addSubview(number)
//        number.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([number.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 5), number.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),number.heightAnchor.constraint(equalToConstant: 20), number.widthAnchor.constraint(equalToConstant: 20)])
//
//    }
    
}
