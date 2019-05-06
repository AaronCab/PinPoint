//
//  HomeControllerExtensionForDelegates.swift
//  PinPoint
//
//  Created by Jason on 4/25/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Firebase

extension HomeController: AuthServiceExistingAccountDelegate, AuthServiceCreateNewAccountDelegate{
    func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
        print("error happened in signin")
    }
    
    func didSignInToExistingAccount(_ authservice: AuthService, user: User) {
        print("suucess login")
    }
    
    func didRecieveErrorCreatingAccount(_ authservice: AuthService, error: Error) {
        print("error with create")
    }
    
    func didCreateNewAccount(_ authservice: AuthService, pinpointUser: ProfileOfUser) {
        print("success log in")
    }
    
    
}

extension HomeController: finallyATransfer{
    func location(place: String) {
        location = place
    }
    
    
}
