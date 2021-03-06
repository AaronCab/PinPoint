//
//  EventsView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class EventsView: UIView {

    lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 388, height: 660)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .white
        return cv
    } ()
    var preferencesButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-slider-100"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .white
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit(){
        self.myCollectionView.register(EventsCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        setup()
        preferencesButtonConstraint()
    }
    
    private func setup() {
        addSubview(myCollectionView)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo:  safeAreaLayoutGuide.bottomAnchor).isActive = true
        myCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        myCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
extension EventsView{
    
    private func preferencesButtonConstraint() {
        addSubview(preferencesButton)
        preferencesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([preferencesButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10), preferencesButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),preferencesButton.heightAnchor.constraint(equalToConstant: 35), preferencesButton.widthAnchor.constraint(equalToConstant: 35)])
    }
}
