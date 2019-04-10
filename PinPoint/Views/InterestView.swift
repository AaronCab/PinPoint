//
//  InterestView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class InterestView: UIView {
    
    lazy var intrestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
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
        self.intrestCollectionView.register(InterestCell.self, forCellWithReuseIdentifier: "InterestCell")
        setup()
    }
    
    private func setup() {
        addSubview(intrestCollectionView)
        intrestCollectionView.translatesAutoresizingMaskIntoConstraints = false
        intrestCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        intrestCollectionView.bottomAnchor.constraint(equalTo:  safeAreaLayoutGuide.bottomAnchor).isActive = true
        intrestCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        intrestCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        intrestCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
