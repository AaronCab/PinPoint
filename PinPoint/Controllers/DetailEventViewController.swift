//
//  DetailEventViewController.swift
//  PinPoint
//
//  Created by Jason on 4/24/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase

class DetailEventViewController: UIViewController {
    var profileView = ProfileView()
    var profileOfUser: ProfileOfUser!
    var events = [EventCreatedByUser]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        eventsMadeByUser()
    }

    
    func uiSetup(){
        profileView.loggedInUserModel = profileOfUser
        let rightBarItem = UIBarButtonItem(customView: profileView.settingsButton)
        profileView.settingsButton.addTarget(self, action: #selector(displayUserStuff), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        view.addSubview(profileView)

    }
    func eventsMadeByUser(){
        DBService.firestoreDB
            .collection(EventCollectionKeys.CollectionKeys).addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error {
                    print("failed to fetch Events with error: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self?.events = snapshot.documents.map { EventCreatedByUser(dict: $0.data()) }
                        .filter({$0.personID == self!.profileOfUser.ProfileId})
                }

        }
    }
    
    @objc func displayUserStuff(){
        let discoverVC = DiscoverViewController()
        discoverVC.events = events
        self.navigationController?.pushViewController(discoverVC, animated: true)
    }

}
