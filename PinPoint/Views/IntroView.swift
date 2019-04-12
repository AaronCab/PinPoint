//
//  IntroView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class IntroView: UIView {

    private var gradient: CAGradientLayer!
    
    private func addGradient(){
        let firstColor = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        let secondColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
        var nameInTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .red
            textField.font = UIFont.init(name: "futura", size: 18)
        textField.placeholder = "Please enter your name"
        textField.layer.cornerRadius = 5
        return textField
        }()
    
    var pictureOfUser: CircularImageView = {
        var imageView = CircularImageView()
        imageView.image = UIImage(named: "placeholder-image")
        imageView.layer.cornerRadius = 300
        return imageView
    }()
    
    var pictureButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Change Picture", for: .normal)
        button.isEnabled = true
        return button
    }()
    
    var locationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Find Location", for: .normal)
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
    
    private func commonInit(){
        addGradient()
        pictureContrant()
        pictureButtonConstrant()
        nameCreatedWithContrant()
        locationButtonConstrant()
    }
    
    
    private func nameCreatedWithContrant(){
        addSubview(nameInTextField)
        nameInTextField.translatesAutoresizingMaskIntoConstraints = false
        nameInTextField.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 30).isActive = true
        nameInTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameInTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        nameInTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

    private func pictureContrant(){
        addSubview(pictureOfUser)
        pictureOfUser.translatesAutoresizingMaskIntoConstraints = false
        pictureOfUser.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.35).isActive = true
        pictureOfUser.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        pictureOfUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        pictureOfUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

   private func pictureButtonConstrant(){
        addSubview(pictureButton)
        pictureButton.translatesAutoresizingMaskIntoConstraints = false
        pictureButton.topAnchor.constraint(equalTo: pictureOfUser.bottomAnchor, constant: 30).isActive = true
        pictureButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        pictureButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        pictureButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

   private func locationButtonConstrant(){
        addSubview(locationButton)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.topAnchor.constraint(equalTo: nameInTextField.bottomAnchor, constant: 30).isActive = true
        locationButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        locationButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

}
