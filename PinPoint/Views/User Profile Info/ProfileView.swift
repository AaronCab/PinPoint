//
//  ProfileView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class ProfileView: UIView {
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
    
    var profilePicture: CircularImageView = {
        let imageView = CircularImageView()
        return imageView
    }()
    
    
    var displayName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 14)
        label.text = " U S E R N A M E"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    var email: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 14)
        label.text = " E M A I L"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 14)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = " N A M E"
        
        return label
    }()
    
    var bioLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2380180061, green: 0.2380180061, blue: 0.2380180061, alpha: 1)
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 20)
        label.text = "B I O"
        return label
    }()
    
    var bio: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.layer.cornerRadius = 10
        textView.isEditable = false
        return textView
    }()
    var settingsButton: UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "PinPoint_Logo_Clear"), for: .normal)
        button.backgroundColor = .clear
        return button 
    }()
    
    private func commonInit(){
        addGradient()
        profilePictureConstraint()
        displayNameConstraint()
        nameConstraint()
        emailConstraint()
        bioLabelConstraint()
        bioConstraint()
        settingsButtonConstraint()
    }
    
    
    var loggedInUserModel: ProfileOfUser?{
        didSet{
            bio.text = loggedInUserModel?.bio ?? ""
            if let picture = loggedInUserModel?.photoURL{
                profilePicture.kf.setImage(with: URL(string: picture), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            }
            name.text = "\(loggedInUserModel?.firstName ?? "") \(loggedInUserModel?.lastName ?? "")"
            displayName.text = loggedInUserModel?.displayName
        }
    }
    
}

extension ProfileView{
    
    private func settingsButtonConstraint() {
        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10), settingsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),settingsButton.heightAnchor.constraint(equalToConstant: 40), settingsButton.widthAnchor.constraint(equalToConstant: 45)])
    }
    
    private func profilePictureConstraint(){
        addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3 ).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        profilePicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 92).isActive = true
        profilePicture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -92).isActive = true
    }
    
    private func displayNameConstraint(){
        addSubview(displayName)
        displayName.translatesAutoresizingMaskIntoConstraints = false
        displayName.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20).isActive = true
        displayName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        displayName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        displayName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func nameConstraint(){
        addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 15).isActive = true
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func emailConstraint(){
        addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        email.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        
        email.heightAnchor.constraint(equalToConstant: 40).isActive = true
        email.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func bioLabelConstraint(){
        addSubview(bioLabel)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    private func bioConstraint(){
        addSubview(bio)
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        bio.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        bio.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        bio.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
}