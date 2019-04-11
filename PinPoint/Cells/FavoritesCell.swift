//
//  FavoritesCell.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    let eventCellContainerView: UIView = {
        let ev = UIView()
        ev.backgroundColor = .clear
        ev.layer.cornerRadius = 20
        ev.layer.masksToBounds = true
        
        return ev
    }()
    
    let eventName: UILabel = {
        let en = UILabel()
        en.text = "Event Name"
        en.numberOfLines = 2
        en.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        et.backgroundColor = .clear
        et.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        et.textColor = .white
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
        button.setTitle("more info", for: .normal)
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
            make.top.equalTo(eventCellContainerView.snp.top)
            
            make.left.equalTo(11)
            
            
        }
        eventImageView.snp.makeConstraints { (make) in
            
            make.topMargin.equalTo(eventName.snp_bottom)
            make.width.equalTo(contentView)
            make.top.equalTo(eventName.snp.bottom)
            make.width.equalTo(eventCellContainerView)
            make.height.equalTo(300)
            
        }
        eventDescription.snp.makeConstraints { (make) in
            make.top.equalTo(400)
            make.width.equalTo(eventCellContainerView)
            make.height.equalTo(150)
            
        }
        eventStartTime.snp.makeConstraints { (make) in
            make.top.equalTo(650)
            make.width.equalTo(eventCellContainerView)
            
        }
        eventEndTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventStartTime.snp_bottom)
            make.width.equalTo(eventCellContainerView)
            
        }
        moreInfoButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(eventCellContainerView.snp.bottom)
            make.left.equalTo(11)
        }
    }
    
}
