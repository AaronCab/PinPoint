//
//  CreateUserView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

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
        let firstColor = UIColor.init(red: 247/255, green: 0/255, blue: 0/255, alpha: 1)
        let secondColor = UIColor.init(red: 247/255, green: 0/255, blue: 0/255, alpha: 1)
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
    
    
    var emailCreatedwith: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        textfield.placeholder = "Email"
        return textfield
    }()
    
    var passwordCreatedWith: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    var displayName: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.textColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        textfield.placeholder = "Display Name"
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
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    
    lazy var stackViewContainer: UIView = {
        let vc = UIView()
        vc.layer.cornerRadius = 10
        vc.layer.masksToBounds = true
        vc.backgroundColor = .clear
        return vc
    }()
    
    lazy var fieldContainerView:  UIStackView = {
        let fv = UIStackView(arrangedSubviews: [displayName,
                                                emailCreatedwith,
                                                passwordCreatedWith ])
        fv.axis = .vertical
        fv.distribution = .fillEqually
        fv.spacing = 2
        fv.layer.masksToBounds = true
        fv.layer.cornerRadius = 10
        return fv
    }()
    
    private func commonInit(){
        addGradient()
        addSubview(cancel)
        addSubview(create)
        setUpView()
    }
    
    private func setUpView() {
        self.addSubview(logo)
        self.addSubview(stackViewContainer)
        stackViewContainer.addSubview(fieldContainerView)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-176)
        }
        stackViewContainer.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(logo.snp.bottom).offset(50)
            make.height.equalTo(150)
        }
        fieldContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(stackViewContainer)
        }
    }
    
}
