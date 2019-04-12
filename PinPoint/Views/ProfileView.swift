//
//  ProfileView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

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
    var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    var displayName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 14)
        label.text = " U S E R N A M E"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    var email: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 14)
        label.text = " E M A I L"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)

        return label
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 15
        label.font = UIFont.init(name: "futura", size: 14)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = " N A M E"

        return label
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
    
    var bio: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        textView.isEditable = false
        return textView
    }()
    
    var signOut: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN OUT", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    var edit: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    var events: UIButton = {
        let button = UIButton()
        button.setTitle("User Events", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private func commonInit(){
        addGradient()
        profilePictureConstrant()
        displayNameConstrant()
        nameConstrant()
        eventsConstrant()
        emailConstrant()
        editConstrant()
        signOutConstrant()
        bioLabelConstrant()
        bioConstrant()

    }
    
}

extension ProfileView{
//
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
    

    
    private func nameConstrant(){
        addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 15).isActive = true
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    }
    
    private func emailConstrant(){
        addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
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
    
    private func eventsConstrant(){
        addSubview(events)
        events.translatesAutoresizingMaskIntoConstraints = false
        events.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        events.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        events.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    
    private func editConstrant(){
        addSubview(edit)
        edit.translatesAutoresizingMaskIntoConstraints = false
        edit.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        edit.leadingAnchor.constraint(equalTo: events.trailingAnchor, constant: 10).isActive = true
        edit.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func signOutConstrant(){
        addSubview(signOut)
        signOut.translatesAutoresizingMaskIntoConstraints = false
        signOut.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        signOut.leadingAnchor.constraint(equalTo: edit.trailingAnchor, constant: 10).isActive = true
        signOut.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        
    }
    
    private func bioConstrant(){
        addSubview(bio)
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.bottomAnchor.constraint(equalTo: events.topAnchor, constant: -10).isActive = true
        bio.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        bio.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        bio.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 25).isActive = true
        
    }
    
}
