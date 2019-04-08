//
//  CreateUserView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreateUserView: UIView {
    

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private var gradient: CAGradientLayer!
    
    private func addGradient(){
        let firstColor = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        let secondColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    private var logo: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .clear
        label.text = "PinPoint"
        label.textColor = .white
        label.font = UIFont.italicSystemFont(ofSize: 30)
        label.textAlignment = .center
        
        return label
    }()
    
    
    var emailCreatedwith: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = .red
        textfield.placeholder = "Email"
        return textfield
    }()
    
    var passwordCreatedWith: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = .red
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    var displayName: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = .red
        textfield.placeholder = "DisplayName"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    lazy var cancel: UIButton = {
        var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    
    lazy var create: UIButton = {
        var button = UIButton()
        button.setTitle("Create acoount", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    
    
    
    
    func commonInit(){
        emailCreatedWithContrant()
        passwordCreatedWithConstant()
        displayNameConstrant()
        logoLabelConstrant()
        addGradient()
        addSubview(cancel)
        addSubview(create)
    }
    
    private func logoLabelConstrant(){
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        logo.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        logo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func emailCreatedWithContrant(){
        addSubview(emailCreatedwith)
        emailCreatedwith.translatesAutoresizingMaskIntoConstraints = false
        emailCreatedwith.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        emailCreatedwith.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        emailCreatedwith.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        emailCreatedwith.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func passwordCreatedWithConstant(){
        addSubview(passwordCreatedWith)
        passwordCreatedWith.translatesAutoresizingMaskIntoConstraints = false
        passwordCreatedWith.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        passwordCreatedWith.topAnchor.constraint(equalTo: emailCreatedwith.bottomAnchor, constant: 30).isActive = true
        passwordCreatedWith.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        passwordCreatedWith.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func displayNameConstrant(){
        addSubview(displayName)
        displayName.translatesAutoresizingMaskIntoConstraints = false
        displayName.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        displayName.bottomAnchor.constraint(equalTo: emailCreatedwith.topAnchor, constant: -30).isActive = true
        displayName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        displayName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
}
