//
//  EditProfileView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    
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
    
    var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder-image")
        return imageView
    }()
    
    var displayName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.font = UIFont.init(name: "futura", size: 14)
        textField.placeholder = " U S E R N A M E"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return textField
    }()
    
    var email: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.font = UIFont.init(name: "futura", size: 14)
        textField.placeholder = " E M A I L"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return textField
    }()
    
    var firstName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.font = UIFont.init(name: "futura", size: 14)
        textField.font = UIFont.systemFont(ofSize: 14, weight: .light)
        textField.placeholder = "First Name"
        return textField
    }()
    
    var lastName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.font = UIFont.init(name: "futura", size: 14)
        textField.font = UIFont.systemFont(ofSize: 14, weight: .light)
        textField.placeholder = "Last Name"
        return textField
    }()
    
    var bioLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 20)
        label.text = "B I O"
        return label
    }()
    
    var bio: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var saveEdit: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-compose-100"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
     
    var picImage: UIButton = {
        let button = UIButton()
         button.setImage(#imageLiteral(resourceName: "icons8-customer-240"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private func commonInit(){
        addGradient()
        profilePictureConstrant()
        displayNameConstrant()
        firstNameConstrant()
        lastNameConstrant()
        picImageConstrant()
        emailConstrant()
        saveEditConstrant()
        bioLabelConstrant()
        bioConstrant()
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
    private func profilePictureConstrant(){
        addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3 ).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        profilePicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        profilePicture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func displayNameConstrant(){
        addSubview(displayName)
        displayName.translatesAutoresizingMaskIntoConstraints = false
        displayName.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20).isActive = true
        displayName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        displayName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        displayName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    
    
    private func firstNameConstrant(){
        addSubview(firstName)
        firstName.translatesAutoresizingMaskIntoConstraints = false
        firstName.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 15).isActive = true
        firstName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        
        firstName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        firstName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func lastNameConstrant(){
        addSubview(lastName)
        lastName.translatesAutoresizingMaskIntoConstraints = false
        lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 15).isActive = true
        lastName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        
        lastName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lastName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func emailConstrant(){
        addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 15).isActive = true
        email.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        
        email.heightAnchor.constraint(equalToConstant: 40).isActive = true
        email.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    
    private func bioLabelConstrant(){
        addSubview(bioLabel)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 15).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func picImageConstrant(){
        addSubview(picImage)
        picImage.translatesAutoresizingMaskIntoConstraints = false
        picImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        picImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        picImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        picImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor,multiplier: 0.3).isActive = true
    }

    
    private func saveEditConstrant(){
        addSubview(saveEdit)
        saveEdit.translatesAutoresizingMaskIntoConstraints = false
        saveEdit.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        saveEdit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        saveEdit.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        saveEdit.heightAnchor.constraint(equalTo:safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true 
        
    }
    
    private func bioConstrant(){
        addSubview(bio)
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.bottomAnchor.constraint(equalTo: picImage.topAnchor, constant: -10).isActive = true
        bio.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        bio.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        bio.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 25).isActive = true
        
    }
    
}
