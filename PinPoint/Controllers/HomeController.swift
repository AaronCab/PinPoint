//
//  HomeController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
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
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(contentView)
        eventsView.myCollectionView.dataSource = self
        eventsView.myCollectionView.delegate = self
        configureNavigationBar()
        getEvents()
    }
    
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
