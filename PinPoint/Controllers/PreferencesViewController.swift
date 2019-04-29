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

class PreferencesViewController: UIViewController {
    var centerController: UIViewController!
    var preferencesView = PreferencesView()
    var locationView = LocationView()
    var locationViewHeight = NSLayoutConstraint()
    

    var currentLocation: CLLocation! {
        didSet{
            preferencesView.locationButton.setTitle(location, for: .normal)
        }
    }
    var locationManager = CLLocationManager()
    var locationService = LocationService()
    var long: Double!
    var lat: Double!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    var location = "Manhattan"
    
    private var selectedImageValue: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        locationViewHeight = locationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        //preferencesView.pictureButton.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        preferencesView.locationButton.addTarget(self, action: #selector(locationFinder), for: .touchUpInside)
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        hideKeyboardWhenTappedAround()
    }
    
    @objc func imagePicker(){
        let alertSheet = UIAlertController(title: "Picture from where?", message: nil, preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        alertSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }))
        }
        alertSheet.addAction(UIAlertAction(title: "Nevermind", style: .cancel, handler: nil))
        present(alertSheet, animated: true, completion: nil)
    }



    @objc func locationFinder(){
        
    }
    
    private func setUpViews(){
//        setUpPrefrencesView()
//        setUpLocationView()
        view.addSubview(locationView)
    }
    private func setUpPrefrencesView(){
        view.addSubview(preferencesView)
        preferencesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preferencesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            preferencesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            preferencesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            preferencesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    private func setUpLocationView(){
    view.addSubview(locationView)
        locationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: preferencesView.searchBar.bottomAnchor),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //   locationView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            locationView.heightAnchor.constraint(equalToConstant: 0)
            
            ])
    }
}



extension PreferencesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("original image is nil")
            return
        }
        let resizedImage = Toucan.init(image: originalImage).resize(CGSize(width: 500, height: 500))
        selectedImageValue = resizedImage.image
        //preferencesView.pictureOfUser.image = resizedImage.image
        dismiss(animated: true)
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
