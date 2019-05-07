//
//  CreatedViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Toucan
import Firebase
import CoreLocation
class CreatedViewController: UIViewController, LocationResultsControllerDelegate {
    var locationDictionary = [String: [Double]]()
    func didSelectCoordinate(_ locationResultsController: LocationResultController, coordinate: CLLocationCoordinate2D, address: String) {
        createdEvent.locationText.text = address
    }
   
    
    func didScrollTableView(_ locationResultsController: LocationResultController) {
        
    }
    
    var preferencesView = PreferencesView()
    var createdEvent = CreatedView()
    var authService = AppDelegate.authservice
    var selectedImage: UIImage!
    var tapGesture = UITapGestureRecognizer()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    var user: UserLogedInModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(createdEvent)
        let leftBarItem = UIBarButtonItem(customView: createdEvent.cancel)
        createdEvent.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: createdEvent.create)
        createdEvent.create.addTarget(self, action: #selector(updateCreatedEvent), for: .touchUpInside)
        createdEvent.create.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        configureInputAccessoryView()
        hideKeyboardWhenTappedAround()
        preferencesView.locationResultsController.delegate = self
    }

    
    private func configureInputAccessoryView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        createdEvent.locationText.inputAccessoryView = toolbar
        let photoLibraryBarItem = UIBarButtonItem(title: "Search",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(searchButtonPressed))
        createdEvent.createdPicture.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
         toolbar.items = [photoLibraryBarItem]
        }
    @objc func searchButtonPressed(){
        navigationItem.searchController = preferencesView.searchController
    }
    @objc func newPicture() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        let cameraBarItem = UIBarButtonItem(barButtonSystemItem: .camera,
                                            target: self,
                                            action: #selector(cameraButtonPressed))
        let photoLibraryBarItem = UIBarButtonItem(title: "Photo Library",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(photoLibraryButtonPressed))
        let flexibleSpaceBarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [cameraBarItem, flexibleSpaceBarItem, photoLibraryBarItem]
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            cameraBarItem.isEnabled = false
        }
    }
    
    @objc func cameraButtonPressed() {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }
    
    @objc func photoLibraryButtonPressed() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
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
 
@objc func dismissView(){
    navigationController?.popViewController(animated: true)
}
    @objc func updateCreatedEvent(){
       
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        let createdStartDate = createdEvent.startText.date
        let endDate = createdEvent.endText.date
        let startDate = Timestamp.init(date: createdStartDate)
        let endDatePick = Timestamp.init(date: endDate)
        
      guard let createdEventDescription = createdEvent.eventText.text,
        !createdEventDescription.isEmpty,
        
        let createdLocationName = createdEvent.locationText.text,
        !createdLocationName.isEmpty,
        let createdEventName = createdEvent.createName.text,
        !createdEventName.isEmpty,
        
         let imageData = selectedImage?.jpegData(compressionQuality: 1.0) else {
            print("missing fields")
            return
        }
        LocationService.getCoordinate(addressString: createdLocationName) { (coordinate, error) in
            if let error = error {
                print("error getting coordinate: \(error)")
            } else {
                let lat = coordinate.latitude
                let long = coordinate.longitude
                self.locationDictionary[createdLocationName] = [lat,long]
                
            }
        }

        guard let user = authService.getCurrentUser() else {
            print("no logged user")
            return
        }
        let docRef = DBService.firestoreDB
            .collection(EventCollectionKeys.CollectionKeys)
            .document()
        StorageService.postImage(imageData: imageData,
                                 imageName: "events/\(user.uid)/\(docRef.documentID)"){ [weak self] (error, imageURL) in
                                    if let error = error {
                                        print("fail to post iamge with error: \(error.localizedDescription)")
                                    } else if let imageURL = imageURL {
                                        print("image posted and recieved imageURL - post event to database: \(imageURL)")
                                        let thisEvent = EventCreatedByUser(location: createdLocationName, createdAt: Date.getISOTimestamp(), personID: user.uid, photoURL: imageURL.absoluteString, eventDescription: createdEventDescription, lat: 42.3601, long: 71.0589, displayName: createdEventName, email: user.email!, isTrustedUser: [], eventType: createdEventName, documentID: docRef.documentID, message: [], pending: [], startedAt: startDate, endDate: endDatePick)
;                                        DBService.postEvent(event: thisEvent){ [weak self] error in
                                            if let error = error {
                                                self?.showAlert(title: "Posting Event Error", message: error.localizedDescription)
                                            } else {
                                                self?.showAlert(title: "Event Posted", message: "Looking forward to checking out your event") { action in
                                                    self?.dismiss(animated: true)
                                                }
                                            }
                                        }
                                        self?.navigationItem.rightBarButtonItem?.isEnabled = true
                                    }
        }

    }
}





extension CreatedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
        selectedImage = resizedImage.image
        createdEvent.createdPicture.setImage(selectedImage, for: .normal)
        dismiss(animated: true)
    }
    
    
}

