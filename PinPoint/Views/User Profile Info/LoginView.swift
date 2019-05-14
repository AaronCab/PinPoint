//
//  LoginView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

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
      //  label.backgroundColor = .brown
        label.text = "P I N P O I N T"
        label.textColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        label.font = UIFont(name: "Futura", size: 36)
        label.textAlignment = .center
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 20
        label.layer.shadowPath = UIBezierPath(rect: label.bounds).cgPath
        label.layer.rasterizationScale = UIScreen.main.scale
        return label
    }()
    var facebookLogIn: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("FACEBOOK LOGIN", for: .normal)
        button.isEnabled = true
        return button
    }()
    var gmailLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("GMAIL LOGIN", for: .normal)
        button.isEnabled = true
        return button
    }()
    var customEmailLogin: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("EXISTING ACCOUNT LOGIN", for: .normal)
        button.isEnabled = true
        return button
    }()
    
    var createAccountHere: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("CREATE NEW ACCOUNT", for: .normal)
        button.isEnabled = true
        return button
    }()
    
    lazy var loginContainertVeiw: UIStackView = {
        
        let fv = UIStackView(arrangedSubviews: [facebookLogIn,
                                                gmailLoginButton,
                                                customEmailLogin,
                                                createAccountHere])
        fv.axis = .vertical
        fv.distribution = .fillEqually
        fv.spacing = 2
        fv.layer.masksToBounds = true
        fv.layer.cornerRadius = 10
        return fv
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
       // addGradient()
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(logo)
        self.addSubview(loginContainertVeiw)
        loginContainertVeiw.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(logo.snp.bottom).offset(50)
            make.height.equalTo(150)
        }
        logo.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-176)
        }
    }
}
