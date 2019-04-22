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
        setupTextField()
         setupTableView()
        
    }
    
    private func setupTableView() {
        addSubview(chatLogTableView)
        chatLogTableView.translatesAutoresizingMaskIntoConstraints = false
        chatLogTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        chatLogTableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        chatLogTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        chatLogTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        chatLogTableView.bottomAnchor.constraint(equalTo: chatTextField.topAnchor).isActive = true
    }
    
    private func setupTextField(){
        addSubview(chatTextField)
        chatTextField.translatesAutoresizingMaskIntoConstraints = false
        chatTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        chatTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        chatTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        chatTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
