//
//  IntroView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class PreferencesView: UIView {

    private var gradient: CAGradientLayer!
    
    private func addGradient(){
        let firstColor = UIColor.init(cgColor: #colorLiteral(red: 0.690956533, green: 0.0340622142, blue: 0.1003342643, alpha: 1))
        let secondColor = UIColor.init(cgColor: #colorLiteral(red: 0.9200486541, green: 0.03262991831, blue: 0.1368149519, alpha: 1))
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
        var categoryCollectionView: UICollectionView =  {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 16
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize.init(width: 100, height: 100)
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
            cv.backgroundColor = .red
            return cv
        }()
    
    var searchBar: UISearchBar = {
      let search = UISearchBar()
        search.layer.cornerRadius = 10.0
        search.backgroundColor = .clear
        search.barTintColor = #colorLiteral(red: 0.7291600108, green: 0.03242072463, blue: 0.1055335626, alpha: 1)
        search.tintColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        search.placeholder = "Change Your Location"
        return search
    }()

    var locationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8669512868, green: 0.8864203095, blue: 0.8792492747, alpha: 0.8279109589)
        button.setTitleColor(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .normal)
        button.setTitle("Find Location", for: .normal)
        button.titleLabel?.font = UIFont(name:
            "futura", size: 18)
        button.isEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        self.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        addGradient()
        setUpView()
    }
   private func setUpView(){
    self.addSubview(searchBar)
    self.addSubview(locationButton)
    
    searchBar.snp.makeConstraints { (make) in
        make.top.equalTo(self.snp.topMargin)
        make.width.equalToSuperview()
    }
    
    locationButton.snp.makeConstraints { (make) in
        make.top.equalTo(searchBar.snp.bottom).offset(10)
        make.left.equalTo(20)
        make.right.equalTo(-20)
        make.height.equalTo(50)
    }
    }

}
