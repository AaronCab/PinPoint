//
//  DiscoverCell.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    let eventCellContainerView: UIView = {
        let ev = UIView()
        ev.backgroundColor = .clear
        ev.layer.cornerRadius = 2.0
        ev.layer.shadowColor = UIColor.lightGray.cgColor
        ev.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        ev.layer.shadowRadius = 3.0
        ev.layer.shadowOpacity = 1.0
        ev.layer.masksToBounds = false
        ev.layer.shadowPath = UIBezierPath(roundedRect: ev.bounds, cornerRadius: ev.layer.cornerRadius).cgPath
        return ev
    }()
    
    let eventName: UILabel = {
        let en = UILabel()
        en.text = "Event Name"
        en.numberOfLines = 2
        en.backgroundColor = .clear
        en.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        en.font = UIFont.init(name: "futura", size: 28)
        en.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        en.layer.cornerRadius = 2.0
        en.layer.shadowColor = UIColor.lightGray.cgColor
        en.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        en.layer.shadowRadius = 3.0
        en.layer.shadowOpacity = 1.0
        en.layer.masksToBounds = false
        en.layer.shadowPath = UIBezierPath(roundedRect: en.bounds, cornerRadius: en.layer.cornerRadius).cgPath
        return en
    }()
    
    let eventImageView: CornerImageView = {
        let ei = CornerImageView()
        ei.image = UIImage(named: "icons8-ask-question-25")
        ei.contentMode = .scaleAspectFit 
        ei.layer.cornerRadius = 20
        ei.layer.masksToBounds = true
        return ei
    }()
    
    let eventDescription: UITextView = {
        let et = UITextView()
        et.isEditable = false
        et.backgroundColor = .clear
        et.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        et.font = UIFont.init(name: "futura", size: 18)
        et.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return et
    }()
    
    let eventLocation: UILabel = {
        let el = UILabel()
        el.backgroundColor = .clear
        el.text = "This is a location"
        el.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        el.font = UIFont.init(name:"futura", size: 18)
        el.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return el
    }()
    
    let eventStartTime: UILabel = {
        let es = UILabel()
        es.text = "Start Time"
        es.font = UIFont.init(name: "futura", size: 18)
        es.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return es
    }()
    
    let eventEndTime: UILabel = {
        let ee = UILabel()
        ee.text = "End Time"
        ee.font = UIFont.init(name: "futura", size: 18)
        ee.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return ee
    }()
    
    let moreInfoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-target-100"), for: .normal)
        return button
    }()
    let calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-planner-100"), for: .normal)
        return button
    }()
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-star-100-2"), for: .normal)
        return button
    }()
    
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = #colorLiteral(red: 0.9917679429, green: 0.985871613, blue: 0.9962999225, alpha: 1) // the color applied to the shadowLayer, rather than the view's backgroundColor

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()

            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.addSubview(eventCellContainerView)
        
        eventCellContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaInsets).offset(20)
            make.bottom.equalTo(safeAreaInsets)
            make.left.equalTo(safeAreaInsets)
            make.right.equalTo(safeAreaInsets)
            
        }
        eventCellContainerView.addSubview(eventName)
        eventCellContainerView.addSubview(eventImageView)
        eventCellContainerView.addSubview(eventDescription)
        eventCellContainerView.addSubview(eventLocation)
        eventCellContainerView.addSubview(eventStartTime)
        eventCellContainerView.addSubview(eventEndTime)
        eventCellContainerView.addSubview(moreInfoButton)
        eventCellContainerView.addSubview(calendarButton)
        eventCellContainerView.addSubview(favoriteButton)
        
        eventName.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaInsets) //(eventCellContainerView.snp.topMargin)
            make.centerX.equalTo(eventCellContainerView.snp.centerX)
            
            
        }
        eventImageView.snp.makeConstraints { (make) in
            
            make.top.equalTo(eventName.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(300)
        }
        eventDescription.snp.makeConstraints { (make) in
            make.top.equalTo(eventImageView.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(100)
        }
        
        eventLocation.snp.makeConstraints { (make) in
            make.top.equalTo(eventDescription.snp.bottom).offset(15)
            make.left.equalTo(20)
          
        }
        eventStartTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventLocation.snp.bottom).offset(15)
            make.left.equalTo(20)
        }
        eventEndTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventStartTime.snp_bottom).offset(5)
            make.left.equalTo(20)
        }
        moreInfoButton.snp.makeConstraints { (make) in
            make.top.equalTo(eventEndTime.snp_bottom).offset(20)
            make.height.width.equalTo(45)
            make.left.equalTo(15)
        }
        favoriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(eventEndTime.snp_bottom).offset(20)
            make.left.equalTo(moreInfoButton.snp_right).offset(20)
            make.height.width.equalTo(45)
        }
        calendarButton.snp.makeConstraints { (make) in
            make.top.equalTo(eventEndTime.snp_bottom).offset(20)
            make.height.width.equalTo(45)
            make.left.equalTo(favoriteButton.snp_right).offset(20)        }
    }
}
