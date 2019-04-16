//
//  CreatedView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CreatedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    lazy var cancel: UIButton = {
        var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    lazy var create: UIButton = {
        var button = UIButton()
        button.setTitle("Create Event", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        return button
    }()
    var createdPicture: UIButton = {
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "placeholder-image"), for: .normal)
        return imageView
    }()

    
    private var gradient: CAGradientLayer!
    var addEventButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-create-25"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    private func addGradient(){
        let firstColor = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        let secondColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
    private func commonInit(){
        addGradient()
        addSubview(cancel)
        addSubview(create)
        createdPictureConstraint()
    }
    
}
extension CreatedView{
    
    private func createdPictureConstraint(){
        addSubview(createdPicture)
        createdPicture.translatesAutoresizingMaskIntoConstraints = false
        createdPicture.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21).isActive = true
        createdPicture.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3 ).isActive = true
        createdPicture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        createdPicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 92).isActive = true
        createdPicture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -92).isActive = true
    }

}

