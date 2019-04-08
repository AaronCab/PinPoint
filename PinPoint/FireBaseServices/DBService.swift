//
//  DBService.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

struct EventCollectionKeys {
    static let CollectionKeys = "event"
    static let PersonID = "personID"
    static let PhotoURL = "PhotoURL"
    static let DisplayNameKey = "displayName"
    static let Lat = "lat"
    static let Long = "long"
    static let EmailKey = "email"
    static let IsTrusted = "isTrusted"
    static let isBlocked = "isBlocked"
    static let CreatedAt = "createdAt"
    static let EventDescription = "eventDescription"
    static let EventType = "eventType"
      static let DocumentIdKey = "documentId"
}
struct ProfileCollectionKeys {
    static let CollectionKey = "Profile"
    static let ProfileIdKey = "ProfileId"
    static let DisplayNameKey = "displayName"
    static let FirstNameKey = "firstName"
    static let LastNameKey = "lastName"
    static let EmailKey = "email"
    static let PhotoURLKey = "photoURL"
    static let CoverImageURLKey = "coverImageURL"
    static let JoinedDateKey = "joinedDate"
    static let BioKey = "bio"
}


final class DBService {
    private init() {}
    
    public static var firestoreDB: Firestore = {
        let db = Firestore.firestore()
        let settings = db.settings
        db.settings = settings
        return db
    }()
    
    static public var generateDocumentId: String {
        return firestoreDB.collection(ProfileCollectionKeys.CollectionKey).document().documentID
    }
    
    static public func createPinPointuser(user: ProfileOfUser, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(ProfileCollectionKeys.CollectionKey)
            .document(user.ProfileId)
            .setData([ ProfileCollectionKeys.CollectionKey : user.ProfileId,
                       ProfileCollectionKeys.DisplayNameKey : user.displayName,
                       ProfileCollectionKeys.EmailKey       : user.email,
                       ProfileCollectionKeys.PhotoURLKey    : user.photoURL ?? "",
                       ProfileCollectionKeys.JoinedDateKey  : user.joinedDate,
                       ProfileCollectionKeys.BioKey         : user.bio ?? ""
            ]) { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    
    static public func postEvent(blog: EventCreatedByUser, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(EventCollectionKeys.CollectionKeys)
            .document(blog.documentId).setData([
                EventCollectionKeys.CreatedAt     : blog.createdAt,
                EventCollectionKeys.PersonID       : blog.personID,
                EventCollectionKeys.EventDescription  : blog.eventDescription,
                EventCollectionKeys.PhotoURL        : blog.photoURL,
                EventCollectionKeys.DocumentIdKey      : blog.documentId
                ])
            { (error) in
                if let error = error {
                    print("posting blog error: \(error)")
                } else {
                    print("blog posted successfully to ref: \(blog.documentId)")
                }
        }
    }
    static public func deleteEvent(blog: EventCreatedByUser, completion: @escaping (Error?) -> Void) {
        DBService.firestoreDB
            .collection(EventCollectionKeys.CollectionKeys)
            .document(blog.personID)
            .delete { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    static public func fetchUser(userId: String, completion: @escaping (Error?, ProfileOfUser?) -> Void) {
        DBService.firestoreDB
            .collection(ProfileCollectionKeys.CollectionKey)
            .whereField(ProfileCollectionKeys.ProfileIdKey, isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(error, nil)
                } else if let snapshot = snapshot?.documents.first {
                    let blogCreator = ProfileOfUser(dict: snapshot.data())
                    completion(nil, blogCreator)
                }
        }
    }
    static public func fetchPinpointUser(userId: String, completion: @escaping (Error?, ProfileOfUser?) -> Void) {
        DBService.firestoreDB
            .collection(ProfileCollectionKeys.CollectionKey)
            .whereField(ProfileCollectionKeys.ProfileIdKey, isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(error, nil)
                } else if let snapshot = snapshot?.documents.first {
                    let blogCreator = ProfileOfUser(dict: snapshot.data())
                    completion(nil, blogCreator)
                }
        }
    }
}