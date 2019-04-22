//
//  Poster.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ProfileOfUser {
    
    let ProfileId: String
    let displayName: String
    let email: String
    let photoURL: String?
    let coverImageURL: String?
    let joinedDate: String
    let firstName: String?
    let lastName: String?
    let bio: String?
    let friends: [String]?
    let blockedUser: [String]?
    
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
         bio: String?,
         friends: [String],
         blockedUser: [String]) {
        self.ProfileId = userId
        self.displayName = displayName
        self.email = email
        self.photoURL = photoURL
        self.coverImageURL = coverImageURL
        self.joinedDate = joinedDate
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
        self.friends = friends
        self.blockedUser = blockedUser
    }
    
    init(dict: [String: Any]) {
        self.ProfileId = dict[ProfileCollectionKeys.CollectionKey] as? String ?? ""
        self.displayName = dict[ProfileCollectionKeys.DisplayNameKey] as? String ?? ""
        self.email = dict[ProfileCollectionKeys.EmailKey] as? String ?? ""
        self.photoURL = dict[ProfileCollectionKeys.PhotoURLKey] as? String ?? ""
        self.coverImageURL = dict[ProfileCollectionKeys.CoverImageURLKey] as? String ?? ""
        self.joinedDate = dict[ProfileCollectionKeys.JoinedDateKey] as? String ?? ""
        self.firstName = dict[ProfileCollectionKeys.FirstNameKey] as? String ?? "FirstName"
        self.lastName = dict[ProfileCollectionKeys.LastNameKey] as? String ?? "LastName"
        self.bio = dict[ProfileCollectionKeys.BioKey] as? String ?? "fellow bloggers are looking forward to reading your bio"
        self.friends = dict[ProfileCollectionKeys.FriendsKey] as? [String] ?? [""]
        self.blockedUser = dict[ProfileCollectionKeys.isBlocked] as? [String] ?? [""]
    }
}
