//
//  EditProfileView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class EditProfileView: UIView {
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var profilePicture: CircularImageView = {
        let imageView = CircularImageView()
        imageView.backgroundColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        return imageView
    }()
    var displayName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9335083961, green: 0.9331413507, blue: 0.9547348619, alpha: 1)
        textField.font = UIFont.init(name: "futura", size: 16)
        textField.placeholder = " U S E R N A M E"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.textColor = #colorLiteral(red: 0.1907173097, green: 0.01004208904, blue: 0.0916705057, alpha: 1)
        return textField
    }()
    var firstName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9335083961, green: 0.9331413507, blue: 0.9547348619, alpha: 1)
        textField.font = UIFont.init(name: "futura", size: 16)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.placeholder = " F I R S T  N A M E"
        textField.textColor = #colorLiteral(red: 0.1907173097, green: 0.01004208904, blue: 0.0916705057, alpha: 1)
        return textField
    }()
    var lastName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9335083961, green: 0.9331413507, blue: 0.9547348619, alpha: 1)
        textField.font = UIFont.init(name: "futura", size: 16)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.placeholder = " L A S T  N A M E"
        textField.textColor = #colorLiteral(red: 0.1907173097, green: 0.01004208904, blue: 0.0916705057, alpha: 1)
        return textField
    }()
    
    var bio: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9213752151, green: 0.2994325757, blue: 0.291195482, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("E D I T  B I O", for: .normal)
        button.layer.cornerRadius = 10
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
                                                firstName,
                                                lastName,
            ])
        fv.axis = .vertical
        fv.distribution = .fillEqually
        fv.spacing = 2
        fv.layer.masksToBounds = true
        fv.layer.cornerRadius = 10
        return fv
    }()
    
    var editButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-save-100").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    var picButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-add-image-100").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private func commonInit(){
        self.backgroundColor = .white
        profilePictureConstraint()
        picButtonConstraint()
        saveEditButtonConstraint()
        bioConstraint()
    }
    
    
    var loggedInUserModel: ProfileOfUser!{
        didSet{
            bio.setTitle(loggedInUserModel.bio ?? "", for: .normal)
            if let picture = loggedInUserModel.photoURL{
                profilePicture.kf.setImage(with: URL(string: picture), placeholder: #imageLiteral(resourceName: "PinPoint_Logo_Clear"))
            }
            else{
                profilePicture.image = UIImage(#imageLiteral(resourceName: "PinPoint_Logo_Clear.png"))
            }
            firstName.text = loggedInUserModel.firstName ?? ""
            lastName.text = loggedInUserModel.lastName ?? ""
            displayName.text = loggedInUserModel.displayName
        }
    }
    
}


extension EditProfileView{
    private func profilePictureConstraint(){
        addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3 ).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        profilePicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 92).isActive = true
        profilePicture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -92).isActive = true
        
        self.addSubview(stackViewContainer)
        stackViewContainer.addSubview(fieldContainerView)
        stackViewContainer.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(profilePicture.snp.bottom).offset(50)
            make.height.equalTo(150)
        }
        fieldContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(stackViewContainer)
        }
        
    }
    
    private func bioConstraint(){
        addSubview(bio)
        bio.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(stackViewContainer.snp.bottom).offset(10)
            make.height.equalTo(25)
        }
        
    }
    private func picButtonConstraint(){
        addSubview(picButton)
        picButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-150)
              make.centerY.equalToSuperview().offset(175)
                    make.height.width.equalTo(60)
        }
    }
    
    
    private func saveEditButtonConstraint(){
        addSubview(editButton)
        
        editButton.snp.makeConstraints { (make) in
            make.top.equalTo(picButton.snp.bottom).offset(10)
            make.height.width.equalTo(60)
            make.right.equalTo(picButton)
        }
        
    }

    
}
