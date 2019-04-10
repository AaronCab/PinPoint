//
//  LoginView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
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
    
    var gmailLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Gmail Login", for: .normal)
        button.isEnabled = true
        return button
    }()
    
    var facebookLogIn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Facebook Login", for: .normal)
        button.isEnabled = true
        return button
    }()
    
    var customEmailLogin: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Login with created account here", for: .normal)
        button.isEnabled = true
        return button
    }()
    
    var createAccountHere: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Create user account", for: .normal)
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
    
    func commonInit(){
        addGradient()
        facebookLoginConstrant()
        gmailLoginConstrant()
        customEmailLoginConstrant()
        logoLabelConstrant()
        createAccountConstrant()
    }
    
    private func facebookLoginConstrant(){
        addSubview(facebookLogIn)
        facebookLogIn.translatesAutoresizingMaskIntoConstraints = false
        facebookLogIn.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        facebookLogIn.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        facebookLogIn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        facebookLogIn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func gmailLoginConstrant(){
        addSubview(gmailLoginButton)
        gmailLoginButton.translatesAutoresizingMaskIntoConstraints = false
        gmailLoginButton.centerXAnchor.constraint(equalTo: facebookLogIn.centerXAnchor, constant: 0).isActive = true
        gmailLoginButton.topAnchor.constraint(equalTo: facebookLogIn.bottomAnchor, constant: 30).isActive = true
        gmailLoginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        gmailLoginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func customEmailLoginConstrant(){
        addSubview(customEmailLogin)
        customEmailLogin.translatesAutoresizingMaskIntoConstraints = false
        customEmailLogin.centerXAnchor.constraint(equalTo: gmailLoginButton.centerXAnchor, constant: 0).isActive = true
        customEmailLogin.topAnchor.constraint(equalTo: gmailLoginButton.bottomAnchor, constant: 30).isActive = true
        customEmailLogin.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        customEmailLogin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func logoLabelConstrant(){
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.centerXAnchor.constraint(equalTo: gmailLoginButton.centerXAnchor, constant: 0).isActive = true
        logo.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        logo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func createAccountConstrant(){
        addSubview(createAccountHere)
        createAccountHere.translatesAutoresizingMaskIntoConstraints = false
        createAccountHere.centerXAnchor.constraint(equalTo: gmailLoginButton.centerXAnchor, constant: 0).isActive = true
        createAccountHere.topAnchor.constraint(equalTo: customEmailLogin.bottomAnchor, constant: 30).isActive = true
        createAccountHere.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        createAccountHere.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    
}
