//
//  EventsCell.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class EventsCell: UICollectionViewCell {
    
    let eventCellContainerView: UIView = {
        let ev = UIView()
        ev.layer.cornerRadius = 20
        ev.layer.masksToBounds = true
    
        return ev
    }()
    
    let eventName: UILabel = {
        let en = UILabel()
        en.text = "Event Name"
        return en
    }()
    
    let eventImageView: UIImageView = {
        let ei = UIImageView()
        ei.image = UIImage(named: "icons8-ask-question-25")
        ei.contentMode = .scaleAspectFill
        ei.layer.cornerRadius = 20
        ei.layer.masksToBounds = true
        return ei
    }()
    
    let eventDescription: UITextView = {
        let et = UITextView()
        et.isEditable = false
        return et
    }()
    
    let eventStartTime: UILabel = {
        let es = UILabel()
        es.text = "Start Time"
        return es
    }()
    
    let eventEndTime: UILabel = {
        let ee = UILabel()
        ee.text = "End Time"
        return ee
    }()
    
    let moreInfoButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "more info"
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
        eventCellContainerView.addSubview(eventStartTime)
        eventCellContainerView.addSubview(eventEndTime)
        eventCellContainerView.addSubview(moreInfoButton)
        
        eventName.snp.makeConstraints { (make) in
            make.top.right.equalTo(11)
            make.top.left.equalTo(-11)
            
        }
        eventImageView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(eventName.snp_bottom)
            make.width.equalTo(contentView)
            make.height.equalTo(30)
            
        }
        eventDescription.snp.makeConstraints { (make) in
            make.top.equalTo(eventImageView.snp_bottom)
            make.width.equalTo(11)
            make.height.equalTo(30)
            
        }
        eventStartTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventDescription.snp_bottom)
            make.width.equalTo(11)
            
        }
        eventEndTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventStartTime.snp_bottom)
            make.width.equalTo(11)

        }
        moreInfoButton.snp.makeConstraints { (make) in
            make.top.equalTo(eventEndTime.snp_bottom)
            make.left.equalTo(11)
        }
    }
}
