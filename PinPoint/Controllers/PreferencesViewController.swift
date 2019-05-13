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
protocol FinallyACatagory {
    func intrest(catagroy: String)
}

class PreferencesViewController: UIViewController {
    var centerController: UIViewController!
    var preferencesView = PreferencesView()
    var locationView = LocationView()
    var locationViewHeight = NSLayoutConstraint()
    var locationViewContorller = LocationResultController()
    
    var categories = [
        "Business": "101",
        "Science & Tech": "102",
        "Music": "103",
        "Film & Media": "104",
        "Arts": "105",
        "Fashion": "106",
        "Health": "107",
        "Sports & Fitness": "108",
        "All": ""]
    var categoriesInAnArray = ["Business", "Science & Tech", "Music","Film & Media","Arts","Fashion", "Health","Sports & Fitness", "All"]
    var currentLocation: CLLocation! {
        didSet{
            preferencesView.locationButton.setTitle(location, for: .normal)
        }
    }
    var delegate: FinallyATransfer?
    var delegateForIntrest: FinallyACatagory?
    var locationManager = CLLocationManager()
    var locationService = LocationService()
    var long: Double!
    var lat: Double!
    
    var location = "Manhattan"{
        didSet{
              locationViewContorller.delegate2 = self
            self.delegate?.location(place: location)

        }
    }
    

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
        preferencesView.locationResultsController.delegate2 = self
        preferencesView.locationResultsController.delegate = self
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
extension PreferencesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return categoriesInAnArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        let category = categoriesInAnArray[indexPath.row]
        cell.categoryName.text = category
        cell.categoryImage.image = UIImage(named: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 7.0
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        cell?.layer.cornerRadius = 25
        let category = categoriesInAnArray[indexPath.row]
        delegateForIntrest?.intrest(catagroy: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
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
                
            }
            
        }
    }
}

extension PreferencesViewController: LocationString{
    func getString(address: String) {
        location = address
    }
    
    
}
extension PreferencesViewController: LocationResultsControllerDelegate{
    func didSelectCoordinate(_ locationResultsController: LocationResultController, coordinate: CLLocationCoordinate2D, address: String) {
        preferencesView.searchController.searchBar.text = address
    }
    
    func didScrollTableView(_ locationResultsController: LocationResultController) {
        
    }
    
    
}

