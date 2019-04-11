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
import FirebaseAuth

class HomeController: UIViewController {
    var contentView = UIView.init(frame: UIScreen.main.bounds)
    func loadFavorites() {
        self.favoriteEvents = FavoritesDataManager.fetchItemsFromDocumentsDirectory()
    }
    let introView = IntroView()
    let eventsView = EventsView()
    let favoriteView = FavoritesView()
    let profileView = ProfileView()
    var eventCell = EventsCell()
    let loginView = LoginView()
    let authService = AppDelegate.authservice
    var event = [Event](){
        didSet {
            DispatchQueue.main.async {
                self.eventsView.myCollectionView.reloadData()
            }
        }
    }
    var favoriteCell = FavoritesCell()
    
    
    private var favoriteEvents = [FavoritesModel]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteView.myCollectionView.reloadData()
            }
        }
    }
    
    var currentLocation = CLLocation(){
        didSet{
            introView.locationButton.setTitle(location, for: .normal)
            locationManager.stopUpdatingLocation()

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
    
    
    var location = "Manhatten"
    var selectedImageValue: UIImage?
    var locationManager: CLLocationManager!
    var locationService = LocationService()
    var long: Double!
    var lat: Double!
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    
    
    
    var delegate: HomeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewdidLoadLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    private func viewdidLoadLayout(){
        view.backgroundColor = .white
        view.addSubview(contentView)
        eventsView.myCollectionView.dataSource = self
        eventsView.myCollectionView.delegate = self
        favoriteView.myCollectionView.delegate = self
        favoriteView.myCollectionView.dataSource = self
        locationManager = CLLocationManager()
        loginViewStuff()
        introViewStuff()
        configureNavigationBar()
        getEvents()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        
    }
    
    
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil, menuCategories: nil)
    }
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "P I N P O I N T"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburgerMenu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    func introPageOn() {
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        contentView.addSubview(introView)
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
        loadFavorites()

        contentView.addSubview(favoriteView)
        view.addSubview(contentView)
    }
    func profilePageOn() {
        if authService.getCurrentUser() == nil{
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            contentView.addSubview(loginView)
            view.addSubview(loginView)
        }else{
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            contentView.addSubview(profileView)
            view.addSubview(profileView)
        }
    }
}


extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate{
   
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favoriteView.myCollectionView{
            return FavoritesDataManager.fetchItemsFromDocumentsDirectory().count
        } else {
            return event.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventsView.myCollectionView {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? EventsCell else { return UICollectionViewCell() }
        let currentEvent = event[indexPath.row]
        cell.eventDescription.text = currentEvent.description?.text
        cell.eventStartTime.text = "Start time: \(currentEvent.start?.local.formatISODateString(dateFormat: "EEEE, MMM d, yyyy") ?? "no start time found")"
        cell.eventEndTime.text = "End Time: \(currentEvent.end?.local.formatISODateString(dateFormat: "MMM d, h:mm a") ?? "no end time found")"
            
        cell.eventName.text = currentEvent.name?.text
        cell.eventImageView.kf.indicatorType = .activity
        cell.moreInfoButton.tag = indexPath.row
        if currentEvent.logo?.original.url == nil{
            cell.eventImageView.image = UIImage(named: "placeholder-image")
        }else{
            cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.logo?.original.url)!), placeholder: UIImage(named: "placeholder-image"))
        }
        cell.moreInfoButton.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
        return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else { return UICollectionViewCell() }
            let currentEvent = FavoritesDataManager.fetchItemsFromDocumentsDirectory()[indexPath.row]
            cell.eventDescription.text = currentEvent.description
            cell.eventStartTime.text = "Start time: \(currentEvent.start)"
            cell.eventEndTime.text = "End Time: \(currentEvent.end)"
            cell.eventName.text = currentEvent.name
            cell.eventImageView.kf.indicatorType = .activity
            cell.moreInfoButton.tag = indexPath.row
            if currentEvent.url == nil{
                cell.eventImageView.image = UIImage(named: "placeholder-image")
            }else{
                cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.url)!), placeholder: UIImage(named: "placeholder-image"))
            }
            cell.moreInfoButton.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func moreInfo(senderTag: UIButton){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let favoriteActione = UIAlertAction(title: "Favorite", style: .default) { alert in
            let thisEvent = self.event[senderTag.tag]
            let favoriteEvent = FavoritesModel.init(name: (thisEvent.name?.text)!, description: (thisEvent.description?.text)!, url: thisEvent.logo?.original.url, start: thisEvent.start!.local, end: thisEvent.end!.local, capacity: thisEvent.capacity, status: thisEvent.status)
            FavoritesDataManager.saveToDocumentsDirectory(favoriteArticle: favoriteEvent)
            self.showAlert(title: "PinPoint", message: "Successfully Favorites Event")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(favoriteActione)
        present(alertController, animated: true)
        
        
        
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
    
    func introViewStuff(){
        introView.pictureButton.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        introView.locationButton.addTarget(self, action: #selector(locationFinder), for: .touchUpInside)
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

        locationManager.startUpdatingLocation()
        
        locationService.getCoordinate(addressString: location) { (locationFound, error) in
            if let error = error{
                self.showAlert(title: "Error", message: error.localizedDescription)
            }else {
                
                self.lat = locationFound.latitude
                self.long = locationFound.longitude
                self.locationManager.stopUpdatingLocation()

            }
        }
        
    }
}

extension HomeController{
    
    func loginViewStuff(){
        loginView.createAccountHere.addTarget(self, action: #selector(createButton), for: .touchUpInside)
        loginView.customEmailLogin.addTarget(self, action: #selector(loginWithExsistingAccount), for: .touchUpInside)
    }
    
    
    @objc func createButton(){
        let createVC = CreateAccountViewController()
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    @objc func loginWithExsistingAccount(){
        let loginWEVC = LoginWithExistingViewController()
        self.navigationController?.pushViewController(loginWEVC, animated: true)
    }
    
    
    
}

