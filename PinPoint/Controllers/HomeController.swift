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

class HomeController: UIViewController{
    
    
    var contentView = UIView.init(frame: UIScreen.main.bounds)
    func loadFavorites() {
        self.favorite = FavoritesDataManager.fetchItemsFromDocumentsDirectory()
    }
    var whatToSeque = detailViewSeque.custom
    let locationResultsController = LocationResultController()
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
    var friendsFound = [ProfileOfUser](){
        didSet{
            self.friendView.chatLogTableView.delegate = self
            self.friendView.chatLogTableView.dataSource = self
            self.friendView.chatLogTableView.reloadData()
        }
    }
    var userProfile: ProfileOfUser!
    
    var friendListener: ListenerRegistration!
    
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
    var intestedIn = "102"{
        didSet{
            self.getCategory(intrest: intestedIn, location: location)
            
        }
    }
    
    private var userModel: UserLogedInModel!
    
    var currentLocation = CLLocation(){
        didSet{
            preferencesView.locationButton.setTitle(location, for: .normal)
            locationManager.stopUpdatingLocation()
            
        }
    }
    
    private func getCategory(intrest: String?, location: String?){
        ApiClient.getCategoryEvents(distance: "10km", location: location?.replacingOccurrences(of: " ", with: "-") ?? "Queens", categoryID: intrest ?? "103") { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                self.event = data
            }
            
        }
    }
    func getString(address: String) {
        self.location = address
    }
    var location = "Manhattan"{
        didSet{
            getCategory(intrest: intestedIn, location: location)
        }
    }
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
        listernerForFriends { (friends, error) in
            if let error = error{
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            if let friends = friends{
                self.friendsFound = friends
            }
        }
        discoverView.discoverCollectionView.reloadData()
        getCategory(intrest: intestedIn, location: location)
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
        if let user = authService.getCurrentUser(){
            DBService.firestoreDB
                .collection(ProfileCollectionKeys.CollectionKey)
                .getDocuments(source: .server, completion: { (data, error) in
                    if let data = data{
                        self.userProfile = data.documents.map { ProfileOfUser(dict: $0.data()) }
                            .filter(){$0.ProfileId == user.uid}.first
                        self.fetchEvents()
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
        self.navigationItem.title = "F R I E N D S"
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
            navigationItem.rightBarButtonItem = nil
            
        } else {
            contentView.removeFromSuperview()
            contentView = UIView.init(frame: UIScreen.main.bounds)
            contentView.addSubview(discoverView)
            view.addSubview(contentView)
            self.navigationItem.title = "P I N P O I N T  E V E N T S"
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
        self.navigationItem.title = "S A V E D  E V E N T S"
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
        } else {
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
            return categoriesInAnArray.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == discoverView.discoverCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCell else { return UICollectionViewCell() }
            let currentEvent = createdEvent[indexPath.row]
            cell.eventDescription.text = currentEvent.eventDescription
            cell.eventName.text = currentEvent.displayName
            cell.eventImageView.kf.indicatorType = .activity
            cell.eventLocation.text = "Located At: \(currentEvent.location)"
            cell.mapsButton.tag = indexPath.row
            
            if let thisDate = currentEvent.startedAt?.dateValue() {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, h:mm a"
                let dateString = dateFormatter.string(from: thisDate)
                cell.eventStartTime.text = "Start Time: \(dateString)"
                
            }
            if let thisDate = currentEvent.endDate?.dateValue() {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, h:mm a"
                let dateString = dateFormatter.string(from: thisDate)
                cell.eventEndTime.text = "End Time: \(dateString)"
            }
            
            cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.photoURL)), placeholder: UIImage(named: "IMG_0279"))
            cell.favoriteButton.tag = indexPath.row
            cell.calendarButton.tag = indexPath.row
            cell.mapsButton.tag = indexPath.row
            cell.mapsButton.addTarget(self, action: #selector(mapDiscover), for: .touchUpInside)
            cell.favoriteButton.addTarget(self, action: #selector(favEventUserCreated), for: .touchUpInside)
            cell.calendarButton.addTarget(self, action: #selector(calDiscover), for: .touchUpInside)
            
            return cell
        }
        if collectionView == eventsView.myCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? EventsCell else { return UICollectionViewCell() }
            let currentEvent = event[indexPath.row]
            cell.eventDescription.text = currentEvent.description?.text
            cell.eventStartTime.text = "Start Time: \(currentEvent.start?.utc.formatISODateString(dateFormat: "MMM d, h:mm a") ?? "no start time found")"
            cell.eventEndTime.text = "End Time: \(currentEvent.end?.utc.formatISODateString(dateFormat: "MMM d, h:mm a") ?? "no end time found")"
            cell.eventName.text = currentEvent.name?.text
            cell.eventImageView.kf.indicatorType = .activity
            cell.favoriteEventButton.tag = indexPath.row
            if currentEvent.logo?.original.url == nil{
                cell.eventImageView.image = UIImage(named: "IMG_0279")
            }else{
                cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.logo?.original.url)!), placeholder: UIImage(named: "IMG_0279"))
            }
            cell.safariEventButton.tag = indexPath.row
            cell.favoriteEventButton.tag = indexPath.row
            cell.calendarEventButton.tag = indexPath.row
            cell.favoriteEventButton.addTarget(self, action: #selector(favEvent), for: .touchUpInside)
            cell.calendarEventButton.addTarget(self, action: #selector(calEvent), for: .touchUpInside)
            cell.safariEventButton.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
            return cell
        }
        if collectionView == favoriteView.myCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else { return UICollectionViewCell() }
            let currentEvent = favorite[indexPath.row]
            cell.eventDescription.text = currentEvent.description
            cell.eventStartTime.text = "Start Time: \(currentEvent.start.formatISODateString(dateFormat: "MMM d, h:mm a"))"
            cell.eventEndTime.text = "End Time: \(currentEvent.end.formatISODateString(dateFormat: "MMM d, h:mm a"))"
            cell.eventName.text = currentEvent.name
            cell.eventImageView.kf.indicatorType = .activity
            cell.moreInfoButton.tag = indexPath.row
            if currentEvent.imageUrl == nil{
                cell.eventImageView.image = UIImage(named: "IMG_0279")
            }else{
                cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.imageUrl)!), placeholder: UIImage(named: "IMG_0279"))
            }
            cell.moreInfoButton.addTarget(self, action: #selector(moreInfoFav), for: .touchUpInside)
            self.loadFavorites()

            return cell
        }
        if collectionView == preferencesView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            let category = categoriesInAnArray[indexPath.row]
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
            cell.favoriteEventButton.tag = indexPath.row
            cell.calendarEventButton.tag = indexPath.row
            cell.safariEventButton.tag = indexPath.row
            cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.photoURL)), placeholder: UIImage(named: "IMG_0279"))
            cell.favoriteEventButton.addTarget(self, action: #selector(moreInfoFav), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    func snapToNearestCell(_ collectionView: UICollectionView) {
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            let collectionViewFlowLayout = (discoverView.discoverCollectionView.collectionViewLayout as! UICollectionViewFlowLayout)
            let itemWithSpaceWidth = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing
            let itemWidth = collectionViewFlowLayout.itemSize.width
            
            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
                let indexPath = IndexPath(item: i, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                break
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView as? UICollectionView) != nil && !decelerate){
            snapToNearestCell(scrollView as! UICollectionView)
        }else{
            
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if ((scrollView as? UICollectionView) != nil){
            snapToNearestCell(scrollView as! UICollectionView)
        }else{
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch whatToSeque {
        case .event:
            print("do nothing")
//            let eventDVC = DetailViewController()
//            eventDVC.event = event[indexPath.row]
//            self.navigationController?.pushViewController(eventDVC, animated: true)
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
        
        let safariActionForNearbyEvents = UIAlertAction(title: "Safari", style: .default) { alert in
            let nearby = self.event[senderTag.tag]
            guard let nearbyURL = nearby.url,
                let url = URL(string: nearbyURL) else {
                    return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(safariActionForNearbyEvents)
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
    @objc func favEventUserCreated(senderTag: UIButton){
        guard let user = authService.getCurrentUser() else {
            showAlert(title: "No logged in user", message: nil)
            return
        }
        let userCreatedEvent = createdEvent[senderTag.tag]
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let favoriteActionForDiscovery = UIAlertAction(title: "Save", style: .default) { alert in
            let thisEvent = self.createdEvent[senderTag.tag]
            if let thisDate = thisEvent.startedAt?.dateValue(){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, h:mm a"
                let dateString = dateFormatter.string(from: thisDate)
                let otherString = dateFormatter.string(from: (thisEvent.endDate?.dateValue())!)
                let favoriteEvent = FavoritesModel.init(name: (thisEvent.displayName), description: (thisEvent.eventDescription), imageUrl: thisEvent.photoURL, start: dateString, end: otherString, capacity: "Creator Decides", status: thisEvent.eventType, url: thisEvent.email)
            FavoritesDataManager.saveToDocumentsDirectory(favoriteArticle: favoriteEvent)
            self.showAlert(title: "PinPoint", message: "Successfully Saved Event")
        }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (action) in
            self.confirmDeletionActionSheet(handler: { (action) in
                
                if user.uid ==  userCreatedEvent.personID{
                    DBService.deleteEvent(blog: userCreatedEvent){ [weak self] (error) in
                        if let error = error {
                            self?.showAlert(title: "Error Deleting Event", message: error.localizedDescription)
                        } else {
                            self?.showAlert(title: "Deleted Event Successfully", message: nil)                        }
                    }
                }
                
            })
        }
        if user.uid == userCreatedEvent.personID{
            alertController.addAction(deleteAction)
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(favoriteActionForDiscovery)
        present(alertController, animated: true)
        
    }
    @objc func favEvent(senderTag: UIButton){
        
        //        let userCreatedEvent = createdEvent[senderTag.tag]
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let favoriteActionForDiscovery = UIAlertAction(title: "Save", style: .default) { alert in
            let thisEvent = self.event[senderTag.tag]
            let favoriteEvent = FavoritesModel.init(name: ((thisEvent.name?.text)!), description: (thisEvent.description?.text)!, imageUrl: thisEvent.logo?.original.url, start: thisEvent.start?.utc ?? "N/A", end: thisEvent.end?.utc ?? "N/A", capacity: "Creator Decides", status: thisEvent.status, url: thisEvent.url)
            FavoritesDataManager.saveToDocumentsDirectory(favoriteArticle: favoriteEvent)
            self.showAlert(title: "PinPoint", message: "Successfully Saved Event")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (action) in
            self.confirmDeletionActionSheet(handler: { (action) in
                
                self.deleteFavorite(senderTag: senderTag)
                
            })
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(favoriteActionForDiscovery)
        present(alertController, animated: true)
        
    }
    @objc func mapDiscover(senderTag: UIButton){
        guard let user = authService.getCurrentUser() else {
            showAlert(title: "No logged in user", message: nil)
            return
        }
        let userCreatedEvent = createdEvent[senderTag.tag]
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let mapLoaction = UIAlertAction(title: "Maps", style: .default) { alert in
            let mapView = MapViewController()
            mapView.modalTransitionStyle = .flipHorizontal
            mapView.venues = self.createdEvent
            self.navigationController?.pushViewController(mapView, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(mapLoaction)
        
        //alertController.addAction(addCalendarAction)
        
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true)
        
    }
    
    @objc func calDiscover(senderTag: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addCalendarAction = UIAlertAction(title: "Add to Calendar", style: .default, handler: { alert in
            let discoverEvent = self.createdEvent[senderTag.tag]
            let formatter = ISO8601DateFormatter()
            guard let start = discoverEvent.startedAt?.dateValue(),
                let end = discoverEvent.endDate?.dateValue() else { return }
            let notes = discoverEvent.eventDescription
            let title = discoverEvent.displayName.description
            
            self.addEventToCalendar(date: start, dateEnd: end, title: title, notes: notes)
            self.showAlert(title: "PinPoint", message: "Successfully Added to Calendar")
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(addCalendarAction)
        
        
        present(alertController, animated: true)
        
    }
    @objc func calEvent(senderTag: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addCalendarAction = UIAlertAction(title: "Add to Calendar", style: .default, handler: { alert in
            let discoverEvent = self.event[senderTag.tag]
            guard let start = discoverEvent.start?.utc,
                let end = discoverEvent.end?.utc,
                let notes = discoverEvent.description?.text,
                let title = discoverEvent.name?.text else { return }
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let startDate = formatter.date(from: start)
            let endDate = formatter.date(from: end)
            self.addEventToCalendar(date: startDate!, dateEnd: endDate!, title: title, notes: notes)
            self.showAlert(title: "PinPoint", message: "Successfully Added to Calendar")
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(addCalendarAction)
        
        
        present(alertController, animated: true)
        
    }
    
    @objc private func fetchEvents(){
        listener = DBService.firestoreDB
            .collection(EventCollectionKeys.CollectionKeys).addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error {
                    print("failed to fetch Events with error: \(error.localizedDescription)")
                }
                if let snapshot = snapshot {
                    self?.createdEvent = snapshot.documents.map { EventCreatedByUser(dict: $0.data()) }.filter(){(self!.userProfile.blockedUser?.contains($0.personID) == false)}
                        .sorted { $0.createdAt.date() > $1.createdAt.date() }
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
            print("no location found")
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
        let alert = UIAlertController(title: "How can I help you?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit Profile", style: .default, handler: { (edit) in
            let editVC = EditProfileViewController()
            editVC.user = self.userProfile
            self.navigationController?.pushViewController(editVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Sign Out", style: .default, handler: { (signOut) in
            self.authService.signOutAccount()
        }))
        alert.addAction(UIAlertAction(title: "User Created Events", style: .default, handler: { (events) in
            self.showAlert(title: "Nothing Yet", message: "Stay Tuned")
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
        preferencesVC.delegateForIntrest = self
        preferencesVC.delegate = self
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

extension HomeController: FinallyACatagory{
    func intrest(catagroy: String) {
        if let catagory = categories[catagroy]{
            intestedIn = catagory
        } else {
            
        }
    }
    
    
}
