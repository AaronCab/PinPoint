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
        ev.layer.cornerRadius = 20
        ev.layer.masksToBounds = true
        return ev
    }()
    
    let eventName: UILabel = {
        let en = UILabel()
        en.numberOfLines = 2
        en.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        en.font = UIFont.init(name: "futura", size: 19)
        en.text = "Event Name"
        en.textColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        return en
    }()
    
    let eventImageView: UIImageView = {
        let ei = UIImageView()
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
        button.setImage(#imageLiteral(resourceName: "icons8-star-80"), for: .normal)
        return button
    }()
    
    
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
            
        }
        eventCellContainerView.addSubview(eventName)
        eventCellContainerView.addSubview(eventImageView)
        eventCellContainerView.addSubview(eventDescription)
        eventCellContainerView.addSubview(eventLocation)
        eventCellContainerView.addSubview(eventStartTime)
        eventCellContainerView.addSubview(eventEndTime)
        eventCellContainerView.addSubview(moreInfoButton)
        
        eventName.snp.makeConstraints { (make) in
            make.top.equalTo(eventCellContainerView.snp.top)
            
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
            make.height.equalTo(50)
            make.left.equalTo(20)
            make.width.equalTo(50)
        }
    }
}
