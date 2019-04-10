//
//  EventsViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Kingfisher
class EventsViewController: UIViewController {
    let eventsView = EventsView()
    var event = [Event](){
        didSet {
            DispatchQueue.main.async {
                self.eventsView.myCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(eventsView)
        eventsView.myCollectionView.delegate = self
        eventsView.myCollectionView.dataSource = self
        getEvents()
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
}
extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
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
        cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.logo?.original.url)!), placeholder: #imageLiteral(resourceName: "icons8-check_male"))
        cell.moreInfoButton.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
        return cell

    }
    @objc func moreInfo(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    }
    
}

