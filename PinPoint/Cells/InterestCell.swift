//
//  InterestCell.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class InterestCell: UICollectionViewCell {
    
    
    public lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setupCollectionNameLabel()
    }
    private func setupCollectionNameLabel() {
        addSubview(collectionNameLabel)
        collectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        collectionNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
        collectionNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        collectionNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
    }
}
