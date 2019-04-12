//
//  AccountExistingView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class AccountExistingView: UIView {

    
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
        label.text = "P I N P O I N T"
        label.textColor = .white
         label.font = UIFont(name: "Futura", size: 36)
        label.textAlignment = .center
        
        return label
    }()
    
    
    var emailToLogin: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = .red
        textfield.layer.cornerRadius = 10
        textfield.placeholder = "Email"
        return textfield
    }()
    
    var passwordToLogin: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = .red
        textfield.placeholder = "Password"
        textfield.layer.cornerRadius = 10
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
    
    lazy var login: UIButton = {
        var button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    
    
    
    
    private func commonInit(){
        emailLoginContrant()
        passwordLoginConstant()
        logoLabelConstrant()
        addGradient()
        addSubview(cancel)
        addSubview(login)
    }
    
    private func logoLabelConstrant(){
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        logo.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        logo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func emailLoginContrant(){
        addSubview(emailToLogin)
        emailToLogin.translatesAutoresizingMaskIntoConstraints = false
        emailToLogin.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        emailToLogin.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        emailToLogin.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        emailToLogin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
   private func passwordLoginConstant(){
        addSubview(passwordToLogin)
        passwordToLogin.translatesAutoresizingMaskIntoConstraints = false
        passwordToLogin.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        passwordToLogin.topAnchor.constraint(equalTo: emailToLogin.bottomAnchor, constant: 30).isActive = true
        passwordToLogin.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        passwordToLogin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
}
