//
//  IntroViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Toucan
import CoreLocation

protocol FinallyATransfer {
    func location(place: String)
}

class PreferencesViewController: UIViewController {
    var centerController: UIViewController!
    var preferencesView = PreferencesView()
    var locationView = LocationView()
    var locationViewHeight = NSLayoutConstraint()
    
    var catagories = [
        "Business": "101",
        "ScienceAndTech": "102",
        "Music": "103",
        "FilmAndMedia": "104",
        "Arts": "105",
        "Fashion": "106",
        "Health": "107",
        "SportsAndFitness": "108",
        "All": ""]
    var catagoriesInAnArray = ["Business", "ScienceAndTech", "Music","FilmAndMedia","Arts","Fashion", "Health","SportsAndFitness", "All"]
    var currentLocation: CLLocation! {
        didSet{
            preferencesView.locationButton.setTitle(location, for: .normal)
        }
    }
    var delegate: FinallyATransfer?
    var locationManager = CLLocationManager()
    var locationService = LocationService()
    var long: Double!
    var lat: Double!
    
    var location = "Manhattan"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        preferencesView.categoryCollectionView.delegate = self
        preferencesView.categoryCollectionView.dataSource = self
        view.addSubview(preferencesView)
        let leftBarItem = UIBarButtonItem(customView: preferencesView.cancel)
        preferencesView.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: preferencesView.create)
        preferencesView.create.addTarget(self, action: #selector(savePreference), for: .touchUpInside)
        preferencesView.create.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        self.navigationItem.searchController = preferencesView.searchController
        preferencesView.locationButton.addTarget(self, action: #selector(locationFinder), for: .touchUpInside)
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc func locationFinder(){
    }
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    @objc func savePreference(){
        
    }
}
extension PreferencesViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return catagoriesInAnArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        let category = catagoriesInAnArray[indexPath.row]
        cell.categoryName.text = category
        cell.categoryImage.image = UIImage(named: category)
        
        return cell
    }
    
    
}

extension PreferencesViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PreferencesViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locational = locations.last else {
            print("no locations found")
            return
        }
        currentLocation = locational
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locational) { (placemarks, error) in
            if let error = error{
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            guard let placeMark = placemarks?.first else { return }
            
            if let city = placeMark.subAdministrativeArea {
                self.location = city
                self.delegate?.location(place: self.location)
            }
            
        }
    }
}

extension PreferencesViewController: LocationString{
    func getString(address: String) {
    }
    
    
}
