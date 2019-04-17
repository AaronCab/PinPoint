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
import Firebase
import FirebaseAuth
import SafariServices

class HomeController: UIViewController {
    var contentView = UIView.init(frame: UIScreen.main.bounds)
    func loadFavorites() {
        self.favoriteEvents = FavoritesDataManager.fetchItemsFromDocumentsDirectory()
    }
    let homeSplashImage = HomeSplashView()
    let preferencesView = PreferencesView()
    let eventsView = EventsView()
    let discoverView = DiscoverView()
    let favoriteView = FavoritesView()
    let profileView = ProfileView()
    var categoryCell = CategoryCell()
    var eventCell = EventsCell()
    let loginView = LoginView()
    let messagesView = MessageView()
    let authService = AppDelegate.authservice
    private var listener: ListenerRegistration!
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
    private var userModel: UserLogedInModel!
    var currentLocation = CLLocation(){
        didSet{
            preferencesView.locationButton.setTitle(location, for: .normal)
            getCategory()
            locationManager.stopUpdatingLocation()
            
        }
    }

    private func getCategory(){
        ApiClient.getCategoryEvents(distance: "5km", location: location, categoryID: "") { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                self.event = data
            }
        
    }
    }
    
    var location = "Manhattan"
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if authService.getCurrentUser() != nil{
            loginView.removeFromSuperview()
        }
    }
    
    private func viewdidLoadLayout(){
        view.backgroundColor = .white
        view.addSubview(homeSplashImage)
        view.addSubview(contentView)
        eventsView.myCollectionView.dataSource = self
        eventsView.myCollectionView.delegate = self
        favoriteView.myCollectionView.delegate = self
        favoriteView.myCollectionView.dataSource = self
        locationManager = CLLocationManager()
        loginViewStuff()
        preferencesViewStuff()
        configureNavigationBar()
        getCategory()
        authService.authserviceSignOutDelegate = self
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
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
    func messagingPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        self.navigationItem.title = "M E S S A G E S"
        contentView.addSubview(messagesView)
        view.addSubview(contentView)
    }
    func eventsPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        self.navigationItem.title = "N E A R B Y  E V E N T S"
        contentView.addSubview(eventsView)
        view.addSubview(contentView)
    }
    
    func discoverPageOn() {
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        contentView.addSubview(discoverView)
        view.addSubview(contentView)
        self.navigationItem.title = "D I S C O V E R"
        let rightBarItem = UIBarButtonItem(customView: discoverView.addEventButton)
        discoverView.addEventButton.addTarget(self, action: #selector(addEventCommand), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        
    }
    
    func preferencesPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        self.navigationItem.title = "P R E F E R E N C E S"
        contentView.addSubview(preferencesView)
        view.addSubview(contentView)
    }
    
    func favoritesPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        loadFavorites()
        self.navigationItem.title = "F A V O R I T E S"
        
        contentView.addSubview(favoriteView)
        view.addSubview(contentView)
    }
    func profilePageOn() {
        if authService.getCurrentUser() == nil{
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            self.navigationItem.title = "P R O F I L E"
            contentView.addSubview(loginView)
            view.addSubview(loginView)
        }else{
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            profileView.profilePicture.image = UIImage(named: "placeholder-image")
            self.navigationItem.title = "P R O F I L E"
            contentView.addSubview(profileView)
            updateUser()
            view.addSubview(profileView)
        }
        
        let rightBarItem = UIBarButtonItem(customView: profileView.settingsButton)
        profileView.settingsButton.addTarget(self, action: #selector(allCommands), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func defaultView(){
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        contentView.addSubview(loginView)

    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favoriteView.myCollectionView{
            return FavoritesDataManager.fetchItemsFromDocumentsDirectory().count }
       else if collectionView == preferencesView.categoryCollectionView {
            return 21
        } else {
            return event.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == preferencesView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            return cell
        } else if collectionView == eventsView.myCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? EventsCell else { return UICollectionViewCell() }
            let currentEvent = event[indexPath.row]
            cell.eventDescription.text = currentEvent.description?.text
            cell.eventStartTime.text = "Start time: \(currentEvent.start?.utc.formatISODateString(dateFormat: "MMM d, h:mm a") ?? "no start time found")"
            cell.eventEndTime.text = "End Time: \(currentEvent.end?.utc.formatISODateString(dateFormat: "MMM d, h:mm a") ?? "no end time found")"
            
            cell.eventName.text = currentEvent.name?.text
            cell.eventImageView.kf.indicatorType = .activity
            cell.moreInfoButton.tag = indexPath.row
            if currentEvent.logo?.original.url == nil{
                cell.eventImageView.image = UIImage(named: "pinpointred")
            }else{
                cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.logo?.original.url)!), placeholder: UIImage(named: "pinpointred"))
            }
            cell.moreInfoButton.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else { return UICollectionViewCell() }
            let currentEvent = FavoritesDataManager.fetchItemsFromDocumentsDirectory()[indexPath.row]
            cell.eventDescription.text = currentEvent.description
            cell.eventStartTime.text = "Start time: \(currentEvent.start.formatISODateString(dateFormat: "MMM d, h:mm a"))"
            cell.eventEndTime.text = "End Time: \(currentEvent.end.formatISODateString(dateFormat: "MMM d, h:mm a"))"
            cell.eventName.text = currentEvent.name
            cell.eventImageView.kf.indicatorType = .activity
            cell.moreInfoButton.tag = indexPath.row
            if currentEvent.imageUrl == nil{
                cell.eventImageView.image = UIImage(named: "pinpointred")
            }else{
                cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.imageUrl)!), placeholder: UIImage(named: "pinpointred"))
            }
            cell.moreInfoButton.addTarget(self, action: #selector(moreInfoFav), for: .touchUpInside)
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventDVC = DetailViewController()
        eventDVC.event = event[indexPath.row]
        self.navigationController?.pushViewController(eventDVC, animated: true)
        
    }
    @objc func moreInfo(senderTag: UIButton){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let favoriteActione = UIAlertAction(title: "Favorite", style: .default) { alert in
            let thisEvent = self.event[senderTag.tag]
            let favoriteEvent = FavoritesModel.init(name: (thisEvent.name?.text)!, description: (thisEvent.description?.text)!, imageUrl: thisEvent.logo?.original.url, start: thisEvent.start!.utc, end: thisEvent.end!.utc, capacity: thisEvent.capacity, status: thisEvent.status, url: thisEvent.url)
            FavoritesDataManager.saveToDocumentsDirectory(favoriteArticle: favoriteEvent)
            self.showAlert(title: "PinPoint", message: "Successfully Favorites Event")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(favoriteActione)
        present(alertController, animated: true)
        
    }
    
    @objc func moreInfoFav(senderTag: UIButton){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alert in
            self.confirmDeletionActionSheet(handler: { (deleteAction) in
                self.deleteFavorite(senderTag: senderTag)
                self.favoriteView.myCollectionView.reloadData()
            })
            
        }
        let safariAction = UIAlertAction(title: "Safari", style: .default) { alert in
            let favorite = FavoritesDataManager.fetchItemsFromDocumentsDirectory()[senderTag.tag]
            guard let favURL = favorite.url,
                let url = URL(string: favURL) else {
                    return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        alertController.addAction(safariAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
    private func deleteFavorite(senderTag: UIButton) {
        let favoriteArticle = favoriteEvents[senderTag.tag]
        FavoritesDataManager.deleteItem(atIndex: senderTag.tag, item: favoriteArticle)
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
    
    func preferencesViewStuff(){
        preferencesView.locationButton.addTarget(self, action: #selector(locationFinder), for: .touchUpInside)
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

extension HomeController: AuthServiceSignOutDelegate{
    func didSignOutWithError(_ authservice: AuthService, error: Error) {
        showAlert(title: "Error signing out", message: error.localizedDescription)
    }
    
    func didSignOut(_ authservice: AuthService) {
        if loginView.isDescendant(of: view){
            loginView.removeFromSuperview()
        }else{
            view.addSubview(loginView)
        }
    }
    
    @objc func allCommands(){
        let alert = UIAlertController(title: "How can I help you", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit Profile", style: .default, handler: { (edit) in
            let editVC = EditProfileViewController()
            self.navigationController?.pushViewController(editVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Sign out", style: .default, handler: { (signOut) in
            self.authService.signOutAccount()
        }))
        alert.addAction(UIAlertAction(title: "User create events", style: .default, handler: { (events) in
            self.showAlert(title: "Nothing Yet", message: "more to come here stay tune")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    @objc func addEventCommand(){
        let createVC = CreatedViewController()
        self.navigationController?.pushViewController(createVC, animated: true)
    }
}

extension HomeController{
    func updateUser(){
        if let user = authService.getCurrentUser(){
            self.listener = DBService.firestoreDB
                .collection(ProfileCollectionKeys.CollectionKey)
                .addSnapshotListener({ (data, error) in
                    if let data = data{
                        self.profileView.loggedInUserModel = data.documents.map { UserLogedInModel(dict: $0.data()) }
                            .filter(){$0.email == user.email}.first
                        
                    }
                })
        }
    }
    
}

extension HomeController{
    
}
