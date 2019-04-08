//
//  Poster.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct PinPointUser {
    let bloggerId: String
    let displayName: String
    let email: String
    let photoURL: String?
    let coverImageURL: String?
    let joinedDate: String
    let firstName: String?
    let lastName: String?
    let bio: String?
    
    public var fullName: String {
        return ((firstName ?? "") + " " + (lastName ?? "")).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(userId: String,
         displayName: String,
         email: String,
         photoURL: String?,
         coverImageURL: String?,
         joinedDate: String,
         firstName: String?,
         lastName: String?,
         bio: String?) {
        self.bloggerId = userId
        self.displayName = displayName
        self.email = email
        self.photoURL = photoURL
        self.coverImageURL = coverImageURL
        self.joinedDate = joinedDate
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
    }
    
    init(dict: [String: Any]) {
        self.bloggerId = dict[PinPointUserCollectionKeys.PinPointUserIdKey] as? String ?? ""
        self.displayName = dict[PinPointUserCollectionKeys.DisplayNameKey] as? String ?? ""
        self.email = dict[PinPointUserCollectionKeys.EmailKey] as? String ?? ""
        self.photoURL = dict[PinPointUserCollectionKeys.PhotoURLKey] as? String ?? ""
        self.coverImageURL = dict[PinPointUserCollectionKeys.CoverImageURLKey] as? String ?? ""
        self.joinedDate = dict[PinPointUserCollectionKeys.JoinedDateKey] as? String ?? ""
        self.firstName = dict[PinPointUserCollectionKeys.FirstNameKey] as? String ?? "FirstName"
        self.lastName = dict[PinPointUserCollectionKeys.LastNameKey] as? String ?? "LastName"
        self.bio = dict[PinPointUserCollectionKeys.BioKey] as? String ?? "fellow bloggers are looking forward to reading your bio"
    }
}
