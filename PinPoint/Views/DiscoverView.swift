//
//  DiscoverView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DiscoverView: UIView {

 
    lazy var discoverCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    } ()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .white
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        backgroundColor = .white
        self.discoverCollectionView.register(InterestCell.self, forCellWithReuseIdentifier: "InterestCell")
        setup()
    }
    
    private func setup() {
        addSubview(discoverCollectionView)
        discoverCollectionView.translatesAutoresizingMaskIntoConstraints = false
        discoverCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        discoverCollectionView.bottomAnchor.constraint(equalTo:  safeAreaLayoutGuide.bottomAnchor).isActive = true
        discoverCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        discoverCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        discoverCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
