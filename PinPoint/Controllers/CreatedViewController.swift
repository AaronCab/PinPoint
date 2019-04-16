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
        //        createdEvent.create.addTarget(self, action: #selector(createProfile), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarItem
        introViewStuff()
    }
    func introViewStuff(){
        createdEvent.createdPicture.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
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
        createdEvent.createdPicture.setImage(resizedImage.image, for: .normal)
        dismiss(animated: true)
    }
    
    
}
