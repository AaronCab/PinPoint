//
//  LocationView.swift
//  PinPoint
//
//  Created by Jason on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class LocationView: UIView {
    public lazy var locationTableView: UITableView = {
        let vtv = UITableView()
        vtv.backgroundColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        return vtv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        self.locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationCell")
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(locationTableView)
        locationTableView.translatesAutoresizingMaskIntoConstraints = false
        locationTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        locationTableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        locationTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        locationTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        locationTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }

}
