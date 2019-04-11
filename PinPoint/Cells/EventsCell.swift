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
        ev.backgroundColor = .clear
        ev.layer.cornerRadius = 20
        ev.layer.masksToBounds = true
    
        return ev
    }()
    
    let eventName: UILabel = {
        let en = UILabel()
        en.text = "Event Name"
        en.numberOfLines = 2
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
<<<<<<< HEAD
            make.topMargin.equalTo(eventName.snp_bottom)
            make.width.equalTo(contentView)
            make.height.equalTo(30)
=======
            make.top.equalTo(eventName.snp.bottom)
            make.width.equalTo(eventCellContainerView)
            make.height.equalTo(300)
>>>>>>> ab74e1fa4588f66ca06be077025fa665dc6a4996
            
        }
        eventDescription.snp.makeConstraints { (make) in
            make.top.equalTo(eventImageView.snp_bottom)
            make.width.equalTo(eventCellContainerView)
            make.height.equalTo(300)
            
        }
        eventStartTime.snp.makeConstraints { (make) in
            make.top.equalTo(eventDescription.snp_bottom)
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
