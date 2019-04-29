//
//  DiscoverViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    var discoverView = DiscoverView()
    
    var events = [EventCreatedByUser](){
        didSet{
           self.discoverView.discoverCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(discoverView)
        discoverView.discoverCollectionView.dataSource = self
        discoverView.discoverCollectionView.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    

}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if events.count != 0{
            return events.count
        }else{
            showAlert(title: "error", message: "This person has made no events")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCell else { return UICollectionViewCell() }
        let currentEvent = events[indexPath.row]
        cell.eventDescription.text = currentEvent.eventDescription
        cell.eventName.text = currentEvent.displayName
        cell.eventImageView.kf.indicatorType = .activity
        cell.eventEndTime.text = "End Date: \(currentEvent.endDate.description)"
        cell.eventStartTime.text = "Start Date: \(currentEvent.startedAt.description)"
        cell.moreInfoButton.tag = indexPath.row
        cell.eventImageView.kf.setImage(with: URL(string: (currentEvent.photoURL)), placeholder: UIImage(named: "pinpointred"))
        return cell
    }
//    func snapToNearestCell(_ collectionView: UICollectionView) {
//        for i in 0..<collectionView.numberOfItems(inSection: 0) {
//            let collectionViewFlowLayout = (discoverView.discoverCollectionView.collectionViewLayout as! UICollectionViewFlowLayout)
//            let itemWithSpaceWidth = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing
//            let itemWidth = collectionViewFlowLayout.itemSize.width
//            
//            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
//                let indexPath = IndexPath(item: i, section: 0)
//                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//                break
//            }
//        }
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        snapToNearestCell(scrollView as! UICollectionView)
//    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        snapToNearestCell(scrollView as! UICollectionView)
//    }
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        snapToNearestCell(scrollView as! UICollectionView)
//
//    }
}

