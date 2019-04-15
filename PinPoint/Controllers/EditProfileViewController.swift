//
//  EditProfileViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Toucan

class EditProfileViewController: UIViewController {
    
    var editProfile = EditProfileView()
    var selectedImage: UIImage!
    var authService = AppDelegate.authservice
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    var user: UserLogedInModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(editProfile)
        introViewStuff()
    }

    
    
    func introViewStuff(){
        editProfile.picImage.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        editProfile.bio.addTarget(self, action: #selector(bioController), for: .touchUpInside)
        editProfile.saveEdit.addTarget(self, action: #selector(updateProifle), for: .touchUpInside)
    }
    
    
    @objc func bioController(){
        let bio = BioViewController()
        bio.delegate = self
        self.navigationController?.pushViewController(bio, animated: true)
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
    @objc func updateProifle(){
        editProfile.saveEdit.isEnabled = false
    
    guard let imageDataforProfile = selectedImage?.jpegData(compressionQuality: 1.0) else {
    return
    }
    
    guard var displayName = editProfile.displayName.text,
        var firstName = editProfile.firstName.text,
        var lastName = editProfile.lastName.text,
        var bio = editProfile.bio.title(for: .normal) else{
            self.showAlert(title: "error", message: nil)
            return
        }
    if displayName.isEmpty || displayName == ""{
    displayName = self.user.displayName
    }
    if firstName.isEmpty || firstName == ""{
        firstName = self.user.firstName ?? "FirstName"
    }
        if lastName.isEmpty || lastName == ""{
            lastName = self.user.lastName ?? "LastName"
        }
        
    if bio.isEmpty || bio == ""{
    bio = self.user.bio ?? "Bio"
    }
    
    if let user = authService.getCurrentUser(){
    
    StorageService.postImage(imageData: imageDataforProfile, imageName: ProfileCollectionKeys.PhotoBucket) { (error, url) in
    if let error = error{
        self.showAlert(title: "error", message: error.localizedDescription)
        
        } else if let urlTwo = url{
    let request = user.createProfileChangeRequest()
    request.displayName = displayName
    request.photoURL = urlTwo
    request.commitChanges(completion: { (error) in
    if let error = error {
        self.showAlert(title: "Error Saving Accoung Info", message: error.localizedDescription)

    }
    })
    DBService.firestoreDB
    .collection(ProfileCollectionKeys.CollectionKey)
    .document(user.uid)
        .updateData([ProfileCollectionKeys.CoverImageURLKey : urlTwo.absoluteString,
    ProfileCollectionKeys.PhotoURLKey: urlTwo.absoluteString,
    ProfileCollectionKeys.DisplayNameKey : displayName ,
    ProfileCollectionKeys.FirstNameKey: firstName ,
    ProfileCollectionKeys.LastNameKey: lastName ,
    ProfileCollectionKeys.BioKey: bio ])
    }
    }
        self.dismiss(animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
        else{
            self.showAlert(title: "Error", message: "User must be logged in")
        }
    }
    
}
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
        editProfile.profilePicture.image = resizedImage.image
        dismiss(animated: true)
    }
    
    
}

extension EditProfileViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditProfileViewController: BioDelegate{
    func bioprotocol(bioText: String) {
         editProfile.bio.setTitle(bioText, for: .normal)
    }
    
    
}
