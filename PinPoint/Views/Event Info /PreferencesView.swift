//
//  IntroView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class PreferencesView: UIView {

    lazy var cancel: UIButton = {
        var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
        return button
    }()
    lazy var create: UIButton = {
        var button = UIButton()
        button.setTitle("Seve", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
        return button
    }()
    let preferenceContainerView: UIView = {
        let pCV = UIView()
        pCV.backgroundColor = .clear
        pCV.layer.masksToBounds = true
        return pCV
    }()
        var categoryCollectionView: UICollectionView =  {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 16
            layout.scrollDirection = .vertical 
            layout.itemSize = CGSize.init(width: 115, height: 115)
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .clear
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
        button.backgroundColor = .white
        button.setTitleColor(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .normal)
        button.setTitle("Find Location", for: .normal)
        button.titleLabel?.font = UIFont(name:
            "futura", size: 18)
        button.layer.cornerRadius = 15
        button.isEnabled = true
        return button
    }()
    
     var locationResultsController: LocationResultController = {
        var locationController = LocationResultController()
        return locationController
        
    }()
    
     lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: locationResultsController)
        sc.searchResultsUpdater = locationResultsController
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.placeholder = "search for your own location"
        sc.dimsBackgroundDuringPresentation = false
        sc.obscuresBackgroundDuringPresentation = false
//        definesPresentationContext = true
        sc.searchBar.autocapitalizationType = .none
        return sc
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        addSubview(cancel)
        addSubview(create)
        self.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
          self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setUpView()
    }
    
   private func setUpView(){
    searchBar = searchController.searchBar
    self.addSubview(preferenceContainerView)
    preferenceContainerView.snp.makeConstraints { (make) in
        make.edges.equalTo(self)
    }
    preferenceContainerView.addSubview(searchBar)
    preferenceContainerView.addSubview(locationButton)
    preferenceContainerView.addSubview(categoryCollectionView)
    
    searchBar.snp.makeConstraints { (make) in
        make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(10)
        make.left.equalTo(10)
        make.right.equalTo(-10)
        make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
    }
    
    locationButton.snp.makeConstraints { (make) in
        make.top.equalTo(searchBar.snp.bottom).offset(15)
        make.left.equalTo(20)
        make.right.equalTo(-20)
        make.height.equalTo(60)
    }
    categoryCollectionView.snp.makeConstraints { (make) in
        make.top.equalTo(locationButton.snp.bottom).offset(30)
        make.left.equalTo(20)
        make.right.equalTo(-20)
        make.height.equalTo(700)
    }
    
    }

}
