//
//  CreatedViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Toucan
class CreatedViewController: UIViewController {
    var createdEvent = CreatedView()
    var authService = AppDelegate.authservice
    var selectedImage: UIImage!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    var user: UserLogedInModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createdEvent)
        let leftBarItem = UIBarButtonItem(customView: createdEvent.cancel)
        createdEvent.cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: createdEvent.create)
        createdEvent.create.addTarget(self, action: #selector(updateCreatedEvent), for: .touchUpInside)
        createdEvent.create.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        configureInputAccessoryView()
    }

    private func configureInputAccessoryView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        createdEvent.textView.inputAccessoryView = toolbar
        let cameraBarItem = UIBarButtonItem(barButtonSystemItem: .camera,
                                            target: self,
                                            action: #selector(cameraButtonPressed))
        let photoLibraryBarItem = UIBarButtonItem(title: "Photo Library",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(photoLibraryButtonPressed))
        let flexibleSpaceBarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [cameraBarItem, flexibleSpaceBarItem, photoLibraryBarItem]
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
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

      guard let createdEventDescription = createdEvent.textView.text,
        !createdEventDescription.isEmpty,
         let imageData = selectedImage?.jpegData(compressionQuality: 1.0) else {
            print("missing fields")
            return
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
                                        print("image posted and recieved imageURL - post dish to database: \(imageURL)")
                                        let thisEvent = EventCreatedByUser(createdAt: Date.getISOTimestamp(), personID: user.uid, photoURL: imageURL.absoluteString, eventDescription: createdEventDescription, lat: 40.4356, long: 50.6785, displayName: user.displayName!, email: user.email!, isTrustedUser: [], isBlocked: false, eventType: "test", documentID: docRef.documentID);                                        DBService.postEvent(event: thisEvent){ [weak self] error in
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
        dismiss(animated: true)

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
        createdEvent.createdPicture.image = selectedImage
        dismiss(animated: true)
    }
    
    
}

