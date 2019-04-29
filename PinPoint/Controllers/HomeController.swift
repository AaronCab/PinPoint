//
//  HomeController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//
//make a bool protocol

import UIKit
import Toucan
import CoreLocation
import EventKit
import Firebase
import FirebaseAuth
import SafariServices

enum detailViewSeque{
    case favorite
    case event
    case custom
    case catagories
}

class HomeController: UIViewController {
    var contentView = UIView.init(frame: UIScreen.main.bounds)
    func loadFavorites() {
        self.favorite = FavoritesDataManager.fetchItemsFromDocumentsDirectory()
    }
    var whatToSeque = detailViewSeque.event
    let homeSplashImage = HomeSplashView()
    let preferencesView = PreferencesView()
    let eventsView = EventsView()
    let discoverView = DiscoverView()
    let favoriteView = FavoritesView()
    let profileView = ProfileView()
    var categoryCell = CategoryCell()
    var eventCell = EventsCell()
    let loginView = LoginView()
    let requestsView = RequestsView()
    let friendView = ChatLogView()
    var eventsInCalendar = EventsDataModel.getEventData()
    var detailUserOfProfile: ProfileOfUser!
    var createDelegate = CreateAccountViewController()
    var logginDelegate = LoginWithExistingViewController()
    var userProfile: ProfileOfUser!

    
    
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
    
    var favorite = FavoritesDataManager.fetchItemsFromDocumentsDirectory(){
        didSet {
            DispatchQueue.main.async {
                self.favoriteView.myCollectionView.reloadData()
            }
        }
    }
    
    
    var authService = AppDelegate.authservice
    
    private var listener: ListenerRegistration!
    var createdEvent = [EventCreatedByUser](){
        didSet{
            DispatchQueue.main.async {
                self.discoverView.discoverCollectionView.reloadData()
            }
        }
    }
    var event = [Event](){
        didSet {
            DispatchQueue.main.async {
                self.eventsView.myCollectionView.reloadData()
            }
        }
    }
    var favoriteCell = FavoritesCell()
    
    
    private var userModel: UserLogedInModel!
    
    var currentLocation = CLLocation(){
        didSet{
            preferencesView.locationButton.setTitle(location, for: .normal)
            getCategory()
            locationManager.stopUpdatingLocation()
            
        }
    }
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        discoverView.discoverCollectionView.refreshControl = rc
        rc.addTarget(self, action: #selector(fetchEvents), for: .valueChanged)
        return rc
    }()
    
    
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
        
        authService.authserviceExistingAccountDelegate = self
        authService.authserviceCreateNewAccountDelegate = self
        preferencesView.categoryCollectionView.dataSource = self
        preferencesView.categoryCollectionView.delegate = self 
        discoverView.discoverCollectionView.delegate = self
        discoverView.discoverCollectionView.dataSource = self
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
        fetchEvents()
        if let user = authService.getCurrentUser(){
        DBService.firestoreDB
            .collection(ProfileCollectionKeys.CollectionKey)
            .getDocuments(source: .server, completion: { (data, error) in
                if let data = data{
                    self.userProfile = data.documents.map { ProfileOfUser(dict: $0.data()) }
                        .filter(){$0.ProfileId == user.uid}.first
                }else if let error = error{
                    self.showAlert(title: nil, message: error.localizedDescription)
                }
            })
        }
    }
    
    func updateFriend(friendID: String, completeion: @escaping (ProfileOfUser?, Error?) -> Void){
        var friendFound: ProfileOfUser!
        if authService.getCurrentUser() != nil{
            self.listener = DBService.firestoreDB
                .collection(ProfileCollectionKeys.CollectionKey)
                .addSnapshotListener({ (data, error) in
                    if let data = data{
                        friendFound = data.documents.map { ProfileOfUser(dict: $0.data()) }
                            .filter(){$0.ProfileId == friendID}.first
                        completeion(friendFound, nil)
                    }
                    if let error = error{
                        completeion(nil, error)
                    }
                })
        }
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil, menuCategories: nil)
    }
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.2061544955, blue: 0.2048995197, alpha: 0.8473619435)
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "P I N P O I N T"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburgerMenu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    func friendRequestsPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        friendView.chatLogTableView.delegate = self
        friendView.chatLogTableView.dataSource = self
        self.navigationItem.title = "F R I E N D  R E Q U E S T S"
        let rightBarItem = UIBarButtonItem(customView: friendView.settingsButton)
        self.navigationItem.rightBarButtonItem = rightBarItem
        friendView.settingsButton.addTarget(self, action: #selector(pendingFreinds), for: .touchUpInside)
        contentView.addSubview(friendView)
        view.addSubview(contentView)
        navigationItem.searchController = nil

    }
    func eventsPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        eventsView.myCollectionView.dataSource = self
        eventsView.myCollectionView.delegate = self
        self.navigationItem.title = "N E A R B Y  E V E N T S"
         let rightBarItem = UIBarButtonItem(customView: eventsView.preferencesButton)
        eventsView.preferencesButton.addTarget(self, action: #selector(preferencesCommand), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        whatToSeque = .event
        contentView.addSubview(eventsView)
        view.addSubview(contentView)
        navigationItem.searchController = nil
        
    }
    
    func discoverPageOn() {
        if authService.getCurrentUser() == nil{
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            self.navigationItem.title = "W E L C O M E"
            view.addSubview(homeSplashImage)
            navigationItem.searchController = nil
        } else {
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            contentView.addSubview(discoverView)
            view.addSubview(contentView)
            self.navigationItem.title = "D I S C O V E R"
            let rightBarItem = UIBarButtonItem(customView: discoverView.addEventButton)
            whatToSeque = .custom
            discoverView.addEventButton.addTarget(self, action: #selector(addEventCommand), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = rightBarItem
            navigationItem.searchController = nil
        }
    }
    
    func preferencesPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        self.navigationItem.title = "P R E F E R E N C E S"
        whatToSeque = .catagories
        contentView.addSubview(preferencesView)
        view.addSubview(contentView)
        navigationItem.searchController = preferencesView.searchController
    }
    
    func favoritesPageOn() {
        self.navigationItem.rightBarButtonItem = nil
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        loadFavorites()
        self.navigationItem.title = "F A V O R I T E S"
        favoriteView.myCollectionView.delegate = self
        favoriteView.myCollectionView.dataSource = self
        whatToSeque = .favorite
        contentView.addSubview(favoriteView)
        view.addSubview(contentView)
        navigationItem.searchController = nil
    }
    func profilePageOn() {
        if authService.getCurrentUser() == nil{
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            self.navigationItem.title = "P R O F I L E"
            contentView.addSubview(loginView)
            view.addSubview(contentView)
            navigationItem.searchController = nil
        }else{
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            profileView.profilePicture.image = UIImage(named: "placeholder-image")
            self.navigationItem.title = "P R O F I L E"
            let rightBarItem = UIBarButtonItem(customView: profileView.settingsButton)
            profileView.settingsButton.addTarget(self, action: #selector(allCommands), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = rightBarItem
            contentView.addSubview(profileView)
            updateUser()
            view.addSubview(contentView)
            navigationItem.searchController = nil
        }
        
        
    }
    
    func defaultView(){
        contentView.removeFromSuperview()
        contentView = UIView.init(frame: UIScreen.main.bounds)
        contentView.addSubview(loginView)
        
    }
}


extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch whatToSeque {
        case .event:
            return event.count
        case .favorite:
            return favorite.count
        case .custom:
            return createdEvent.count
        case .catagories:
            return catagoriesInAnArray.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == discoverView.discoverCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCell else { return UICollectionViewCell() }
            let currentEvent = createdEvent[indexPath.row]
            cell.eventDescription.text = currentEvent.eventDescription
            cell.eventName.text = currentEvent.displayName
            cell.eventImageView.kf.indicatorType = .activity
            cell.moreInfoButton.tag = indexPath.row
            cell.eventStartTime.text = "Start Date: \(currentEvent.startedAt.description.formatISODateString(dateFormat: "MMM d, h:mm a"))"
            cell.eventEndTime.text = "End Date: \(currentEvent.endDate.description.formatISODateString(dateFormat: "MMM d, h:mm a"))"
            cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.photoURL)), placeholder: UIImage(named: "pinpointred"))
            cell.moreInfoButton.addTarget(self, action: #selector(moreInfoDisvover), for: .touchUpInside)
            return cell
        }
        if collectionView == eventsView.myCollectionView {
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
        }
        if collectionView == favoriteView.myCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else { return UICollectionViewCell() }
            let currentEvent = favorite[indexPath.row]
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
        if collectionView == preferencesView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            let category = catagoriesInAnArray[indexPath.row]
            cell.categoryName.text = category
            cell.categoryImage.image = UIImage(named: category)
            
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? EventsCell else { return UICollectionViewCell() }
            let currentEvent = createdEvent[indexPath.row]
            cell.eventDescription.text = currentEvent.eventDescription
            cell.eventName.text = currentEvent.displayName
            cell.eventImageView.kf.indicatorType = .activity
            cell.moreInfoButton.tag = indexPath.row
            cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.photoURL)), placeholder: UIImage(named: "pinpointred"))
            cell.moreInfoButton.addTarget(self, action: #selector(moreInfoFav), for: .touchUpInside)
            
            return cell
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch whatToSeque {
        case .event:
            let eventDVC = DetailViewController()
            eventDVC.event = event[indexPath.row]
            self.navigationController?.pushViewController(eventDVC, animated: true)
        case .favorite:
            let favoriteDVC = DetailViewController()
            favoriteDVC.favorite = favorite[indexPath.row]
            self.navigationController?.pushViewController(favoriteDVC, animated: true)
        case .custom:
            let customDVC = DetailViewController()
            DBService.firestoreDB
                .collection(ProfileCollectionKeys.CollectionKey)
                .getDocuments(source: .server, completion: { (data, error) in
                    if let data = data{
                        let otherUser = data.documents.map { ProfileOfUser(dict: $0.data()) }
                            .filter(){$0.ProfileId == self.createdEvent[indexPath.row].personID}.first
                        customDVC.profileOfUser = otherUser
                        customDVC.custom = self.createdEvent[indexPath.row]
                        self.navigationController?.pushViewController(customDVC, animated: true)
                    }else if let error = error{
                        print(error)
                    }
                })
            
        case .catagories:
            //let catdvc = PreferencesView()
            print("end it here")
        }
        
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
        let addCalendarAction = UIAlertAction(title: "Add to Calendar", style: .default, handler: { alert in
            let thisEvent = self.event[senderTag.tag]
            let formatter = ISO8601DateFormatter()
            guard let start = thisEvent.start?.utc,
                let end = thisEvent.end?.utc,
                let dateStart = formatter.date(from: start),
                let dateEnd = formatter.date(from: end),
                let notes = thisEvent.description?.text,
                let title = thisEvent.name?.text else { return }
            
            
            self.addEventToCalendar(date: dateStart, dateEnd: dateEnd, title: title, notes: notes)
            self.showAlert(title: "PinPoint", message: "Successfully Added to Calendar")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(favoriteActione)
        alertController.addAction(addCalendarAction)
        present(alertController, animated: true)
        
    }
    func addEventToCalendar(date: Date, dateEnd: Date, title: String, notes: String) {
        let eventStore: EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) {(granted, error) in
            if (granted) && (error == nil)
            {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = date
                event.endDate = dateEnd
                event.notes = notes
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError{
                    print("error: \(error)")
                }
                
            } else {
                print("error: \(error)")
            }
        }
        print("pressed")
    }
    @objc func moreInfoDisvover(senderTag: UIButton){
        guard let user = authService.getCurrentUser() else {
            print("no logged user")
            return
        }
        let userCreatedEvent = createdEvent[senderTag.tag]
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (action) in
            self.confirmDeletionActionSheet(handler: { (action) in
                
                if user.uid ==  userCreatedEvent.personID{
                    DBService.deleteEvent(blog: userCreatedEvent){ [weak self] (error) in
                        if let error = error {
                            self?.showAlert(title: "Error deleting event", message: error.localizedDescription)
                        } else {
                            self?.showAlert(title: "Deleted successfully", message: nil)                        }
                    }
                }
                
            })
        }
        if user.uid == userCreatedEvent.personID{
            alertController.addAction(deleteAction)
            
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
    
    @objc private func fetchEvents(){
        refreshControl.beginRefreshing()
        listener = DBService.firestoreDB
            .collection(EventCollectionKeys.CollectionKeys).addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error {
                    print("failed to fetch Events with error: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self?.createdEvent = snapshot.documents.map { EventCreatedByUser(dict: $0.data()) }
                        .sorted { $0.createdAt.date() > $1.createdAt.date() }
                }
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
        }
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
        let favoriteArticle = favorite[senderTag.tag]
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
        LocationService.getCoordinate(addressString: location) { (locationFound, error) in
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
    @objc func preferencesCommand(){
    let preferencesVC = PreferencesViewController()
    self.navigationController?.pushViewController(preferencesVC, animated: true)
    }
}

extension HomeController{
    func updateUser(){
        if let user = authService.getCurrentUser(){
            self.listener = DBService.firestoreDB
                .collection(ProfileCollectionKeys.CollectionKey)
                .addSnapshotListener({ (data, error) in
                    if let data = data{
                        self.profileView.loggedInUserModel = data.documents.map { ProfileOfUser(dict: $0.data()) }
                            .filter(){$0.ProfileId == user.uid}.first
                        
                    }
                })
        }
    }
    
}
