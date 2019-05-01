//
//  AccountExistingView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

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
        label.textColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        label.font = UIFont(name: "Futura", size: 36)
        label.textAlignment = .center
        
        return label
    }()
    
    
    var emailToLogin: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        textfield.textColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        textfield.placeholder = "Email"
        return textfield
    }()
    
    var passwordToLogin: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        textfield.textColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    lazy var textFieldContainerVew: UIView = {
        let tfv = UIView()
        tfv.layer.cornerRadius = 10
        tfv.layer.masksToBounds = true
        tfv.backgroundColor = .clear
        return tfv
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
        logoLabelConstrant()
        setUpViews()
        addSubview(cancel)
        addSubview(login)
    }
    
    private func setUpViews() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(textFieldContainerVew)

         textFieldContainerVew.addSubview(emailToLogin)
          textFieldContainerVew.addSubview(passwordToLogin)
        textFieldContainerVew.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(375)
            make.height.equalTo(100)
            
        }
        
        emailToLogin.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        passwordToLogin.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(emailToLogin.snp_bottom).offset(2)
            make.bottom.equalTo(textFieldContainerVew.snp.bottom)
        }
    }
    
    private func logoLabelConstrant(){
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        logo.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        logo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
