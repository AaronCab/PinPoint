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
    var createdPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder-image")
        return imageView
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Event Name"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.font = UIFont.init(name: "futura", size: 16)
        label.textAlignment = .center
        return label
    }()
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.9397123456, green: 0.7953640819, blue: 0.7539283037, alpha: 1)
        textView.font = UIFont(name:"futura" , size:18);
        return textView
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
        addSubview(label)
        addSubview(textView)
        addSubview(createdPicture)
        label.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.snp_topMargin).offset(15)
            make.width.equalTo(350)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        createdPicture.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom)
            make.width.equalTo(350)
            make.height.equalTo(350)
            make.centerX.equalTo(self.snp.centerX)
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(createdPicture.snp.bottom).offset(15)
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.height.equalTo(200)
        }
    }
    
}
extension CreatedView{
    
//        private func imageConstraints(){
//        addSubview(createdPicture)
//        createdPicture.translatesAutoresizingMaskIntoConstraints = false
//        createdPicture.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
//        createdPicture.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
//        createdPicture.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
//        createdPicture.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor).isActive = true
//    }
//    private func labelConstraint(){
//        addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: createdPicture.bottomAnchor, constant: 8).isActive = true
//        label.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: 30).isActive = true
//
//    }
//
//    private func textViewConstraint(){
//        addSubview(textView)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
//        textView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
//        textView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
//        textView.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor).isActive = true
//
//    }

}

