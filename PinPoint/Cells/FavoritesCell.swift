//
//  FavoritesCell.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesCell: UICollectionViewCell {
    
    let eventCellContainerView: UIView = {
        let ev = UIView()
        ev.backgroundColor = .clear
        ev.layer.cornerRadius = 2.0
        ev.layer.masksToBounds = true
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
        en.textAlignment = .center
        en.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        en.font = UIFont.init(name: "futura", size: 28)
        en.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        en.backgroundColor = .clear
        en.layer.masksToBounds = true
        en.layer.shadowColor = UIColor.lightGray.cgColor
        en.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        en.layer.shadowRadius = 1.0
        en.layer.shadowOpacity = 1.0
        en.layer.masksToBounds = false
        return en
    }()
    
    let eventImageView: CornerImageView = {
        let ei = CornerImageView()
        ei.image = UIImage(named: "icons8-ask-question-25")
        ei.contentMode = .scaleAspectFit
        ei.layer.shadowColor = UIColor.red.cgColor
        ei.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        ei.layer.cornerRadius = 20
        ei.layer.masksToBounds = true
        return ei
    }()
    
    let eventDescription: UITextView = {
        let et = UITextView()
        et.isEditable = false
        et.backgroundColor = #colorLiteral(red: 0.9610863328, green: 0.9553727508, blue: 0.965478003, alpha: 1)
        et.layer.cornerRadius = 10
        et.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        et.font = UIFont.init(name: "futura", size: 18)
        et.textColor = #colorLiteral(red: 0.2158689201, green: 0.05760341883, blue: 0.03225985169, alpha: 1)
        et.layer.borderWidth = 2.0
        et.layer.borderColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        et.layer.shadowColor = UIColor.lightGray.cgColor
        et.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        et.layer.shadowRadius = 3.0
        et.layer.shadowOpacity = 1.0
        et.layer.shadowPath = UIBezierPath(roundedRect: et.bounds, cornerRadius: et.layer.cornerRadius).cgPath
        return et
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
        ee.font = UIFont.init(name: "futura", size: 18)
        ee.text = "End Time"
        ee.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return ee
    }()
    
    let moreInfoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-about-80"), for: .normal)
        return button
    }()
    
    let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        return view
    }()

    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 3
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.addSubview(eventCellContainerView)
        
        eventCellContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
            make.top.equalTo(safeAreaInsets).offset(20)
            make.bottom.equalTo(safeAreaInsets)
            make.left.equalTo(safeAreaInsets)
            make.right.equalTo(safeAreaInsets)
            
        }
        eventCellContainerView.addSubview(eventName)
        eventCellContainerView.addSubview(eventImageView)
        eventCellContainerView.addSubview(eventDescription)
        eventCellContainerView.addSubview(eventStartTime)
        eventCellContainerView.addSubview(eventEndTime)
        eventCellContainerView.addSubview(moreInfoButton)
        
        eventName.snp.makeConstraints { (make) in
            make.top.equalTo(eventCellContainerView.snp.top)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        eventImageView.snp.makeConstraints { (make) in
            make.top.equalTo(eventName.snp.bottom).offset(7)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(250)
        }
        
        eventDescription.snp.makeConstraints { (make) in
            make.top.equalTo(eventImageView.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(175)
            
        }
        
        eventStartTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventDescription.snp.bottom).offset(10)
            make.left.equalTo(20)
            
        }
        
        eventEndTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventStartTime.snp_bottom).offset(5)
           make.left.equalTo(20)
        }
        
        moreInfoButton.snp.makeConstraints { (make) in
            make.top.equalTo(eventEndTime.snp_bottom).offset(10)
            make.height.equalTo(50)
            make.left.equalTo(20)
            make.width.equalTo(50)
        }

    }
}
