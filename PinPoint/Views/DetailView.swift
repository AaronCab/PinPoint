//
//  DetailView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class DetailView: UIView {

    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Name"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.font = UIFont.init(name: "futura", size: 30)
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icons8-ask-question-25")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .yellow
        textView.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textView.font = UIFont.init(name: "futura", size: 18)
        textView.textColor = .white
        return textView
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
        self.backgroundColor = #colorLiteral(red: 0.910360992, green: 0.1213598326, blue: 0.1217759624, alpha: 1)
        setUpView()
    }
    private func setUpView(){
        self.addSubview(detailLabel)
        self.addSubview(detailImageView)
        self.addSubview(detailTextView)
        detailLabel.snp.makeConstraints { (make) in
            make.width.equalTo(350)
        }
        detailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.topMargin)
            make.width.equalTo(350)
            make.height.equalTo(350)
            make.centerX.equalTo(self.snp.centerX)
        }
        detailTextView.snp.makeConstraints { (make) in
            make.top.equalTo(detailImageView.snp.bottom).offset(15)
            make.left.equalTo(20)
        }
        
    }
}
