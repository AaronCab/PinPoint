//
//  InterestView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class RequestsView: UIView {
    
    lazy var messageCollectionView: UICollectionView = {
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
        self.messageCollectionView.register(InterestCell.self, forCellWithReuseIdentifier: "InterestCell")
        setup()
    }
    
    private func setup() {
        addSubview(messageCollectionView)
        messageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        messageCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        messageCollectionView.bottomAnchor.constraint(equalTo:  safeAreaLayoutGuide.bottomAnchor).isActive = true
        messageCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        messageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
