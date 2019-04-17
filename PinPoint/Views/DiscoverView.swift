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
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 400, height: 750)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .red
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
    var addEventButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-create-25"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    private func commonInit(){
        backgroundColor = .white
        self.discoverCollectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "DiscoverCell")
        setup()
        addEventButtonConstraint()
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
extension DiscoverView{
    
    private func addEventButtonConstraint() {
        addSubview(addEventButton)
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addEventButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10), addEventButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),addEventButton.heightAnchor.constraint(equalToConstant: 40), addEventButton.widthAnchor.constraint(equalToConstant: 45)])
    }
}

