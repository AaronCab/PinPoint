//
//  MapView.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 5/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class MapView: UIView {

    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
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
        backgroundColor = .white
        setUpViews()
    }
    private func setUpViews() {
        setupMapView()
    }
    private func setupMapView() {
        addSubview(mapView)
        //mapView.backgroundColor = .yellow
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}
