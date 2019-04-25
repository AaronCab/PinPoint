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
        return imageView
    }()
    var displayName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.init(name: "futura", size: 16)
        textField.placeholder = " U S E R N A M E"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return textField
    }()
    var firstName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.init(name: "futura", size: 16)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.placeholder = " F I R S T  N A M E"
        return textField
    }()
    var lastName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.init(name: "futura", size: 16)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.placeholder = " L A S T  N A M E"
        return textField
    }()
    
    var bio: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9213752151, green: 0.2994325757, blue: 0.291195482, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("B I O", for: .normal)
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
    
    var saveEdit: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-contact-100").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    var picImage: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-favorite-folder-100").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private func commonInit(){
        self.backgroundColor = .white
        profilePictureConstraint()
        picImageConstraint()
        saveEditConstraint()
        bioConstraint()
    }
    
    
    var loggedInUserModel: ProfileOfUser!{
        didSet{
            bio.setTitle(loggedInUserModel.bio ?? "", for: .normal)
            if let picture = loggedInUserModel.photoURL{
                profilePicture.kf.setImage(with: URL(string: picture), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            }
            else{
                profilePicture.image = UIImage(named: "placeholder-image")
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
    private func picImageConstraint(){
        addSubview(picImage)
        picImage.translatesAutoresizingMaskIntoConstraints = false
        picImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        picImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        picImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.10).isActive = true
        picImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor,multiplier: 0.10).isActive = true
    }
    
    
    private func saveEditConstraint(){
        addSubview(saveEdit)
    saveEdit.translatesAutoresizingMaskIntoConstraints = false
        saveEdit.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        saveEdit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        saveEdit.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.10).isActive = true
        saveEdit.heightAnchor.constraint(equalTo:safeAreaLayoutGuide.heightAnchor, multiplier: 0.10).isActive = true
        
    }
    
    private func bioConstraint(){
        addSubview(bio)
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        bio.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        bio.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 25).isActive = true
        
    }
    
}
