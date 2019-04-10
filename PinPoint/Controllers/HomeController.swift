//
//  HomeController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Toucan
import CoreLocation

class HomeController: UIViewController {
    var contentView = UIView.init(frame: UIScreen.main.bounds)
    
    
 
    let introView = IntroView()
    let eventsView = EventsView()
    let favoriteView = FavoritesView()
    let profileView = ProfileView()
    var event = [Event](){
        didSet {
            DispatchQueue.main.async {
                self.eventsView.myCollectionView.reloadData()
            }
        }
    }
    
    var currentLocation = CLLocation(){
        didSet{
            introView.locationButton.setTitle(location, for: .normal)
        }
    }
    private func getEvents(){
        ApiClient.getEvents(distance: "2km", location: "Manhattan") { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                self.event = data
            }
        }
    }

    var delegate: HomeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(contentView)
        eventsView.myCollectionView.dataSource = self
        eventsView.myCollectionView.delegate = self
 
        configureNavigationBar()
        getEvents()
    }
    
    
        var location = "Manhatten"
        var selectedImageValue: UIImage?
        var locationManager = CLLocationManager()
        var locationService = LocationService()
        var long: Double!
        var lat: Double!
        private lazy var imagePickerController: UIImagePickerController = {
            let ip = UIImagePickerController()
            ip.delegate = self
            return ip
        }()
    
    // MARK: - Handlers
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil, menuCategories: nil)
    }
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburgerMenu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    func introPageOn() {
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)

        view.addSubview(contentView)
    }
    func eventsPageOn() {
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        contentView.addSubview(eventsView)
        view.addSubview(contentView)
    }
    func favoritesPageOn() {
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        contentView.addSubview(favoriteView)
        view.addSubview(contentView)
    }
    func profilePageOn() {
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        contentView.addSubview(profileView)
        view.addSubview(profileView)
    }
}


extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return event.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? EventsCell else { return UICollectionViewCell() }
        let currentEvent = event[indexPath.row]
        cell.eventDescription.text = currentEvent.description?.text
        cell.eventStartTime.text = currentEvent.start?.local
        cell.eventEndTime.text = currentEvent.end?.local
        cell.eventName.text = currentEvent.name?.text
        cell.eventImageView.kf.indicatorType = .activity
        if currentEvent.logo?.original.url == nil{
            cell.eventImageView.image = UIImage(named: "placeholder-image")
        }else{
        cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.logo?.original.url)!), placeholder: UIImage(named: "placeholder-image"))
        }
        cell.moreInfoButton.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
        return cell
    }
    
    @objc func moreInfo(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    }
    
    
}

extension HomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
        introView.pictureOfUser.image = resizedImage.image
        dismiss(animated: true)
    }
}

extension HomeController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HomeController: CLLocationManagerDelegate {
    
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

extension HomeController{
    
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
//        locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        currentLocation = locationManager.location!
//        locationManager.stopUpdatingLocation()
        
        locationService.getCoordinate(addressString: location) { (locationFound, error) in
            if let error = error{
                self.showAlert(title: "Error", message: error.localizedDescription)
            }else {
                self.lat = locationFound.latitude
                self.long = locationFound.longitude
            }
        }
        
    }
}
