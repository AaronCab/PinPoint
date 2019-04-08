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

struct PinPointUserCollectionKeys {
    static let CollectionKey = "pinpointuser"
    static let PinPointUserIdKey = "pinpointId"
    static let DisplayNameKey = "displayName"
    static let FirstNameKey = "firstName"
    static let LastNameKey = "lastName"
    static let EmailKey = "email"
    static let PhotoURLKey = "photoURL"
    static let CoverImageURLKey = "coverImageURL"
    static let JoinedDateKey = "joinedDate"
    static let BioKey = "bio"
}

struct EventPostCollectionKeys {
    static let CollectionKey = "eventPosts"
    static let EventPostDescritionKey = "eventPostDescription"
    static let PinPointUserIdKey = "pinpointId"
    static let CreatedDateKey = "createdDate"
    static let DocumentIdKey = "documentId"
    static let ImageURLKey = "imageURL"
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
        return firestoreDB.collection(PinPointUserCollectionKeys.CollectionKey).document().documentID
    }
    
    static public func createBlogger(blogger: PinPointUser, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(PinPointUserCollectionKeys.CollectionKey)
            .document(blogger.bloggerId)
            .setData([ EventPostCollectionKeys.PinPointUserIdKey : blogger.bloggerId,
                       PinPointUserCollectionKeys.DisplayNameKey : blogger.displayName,
                       PinPointUserCollectionKeys.EmailKey       : blogger.email,
                       PinPointUserCollectionKeys.PhotoURLKey    : blogger.photoURL ?? "",
                       PinPointUserCollectionKeys.JoinedDateKey  : blogger.joinedDate,
                       PinPointUserCollectionKeys.BioKey         : blogger.bio ?? ""
            ]) { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    
    static public func postBlog(blog: EventPost, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(EventPostCollectionKeys.CollectionKey)
            .document(blog.documentId).setData([
                EventPostCollectionKeys.CreatedDateKey     : blog.createdDate,
                EventPostCollectionKeys.PinPointUserIdKey       : blog.bloggerId,
                EventPostCollectionKeys.EventPostDescritionKey  : blog.blogDescription,
                EventPostCollectionKeys.ImageURLKey        : blog.imageURL,
                EventPostCollectionKeys.DocumentIdKey      : blog.documentId
                ])
            { (error) in
                if let error = error {
                    print("posting blog error: \(error)")
                } else {
                    print("blog posted successfully to ref: \(blog.documentId)")
                }
        }
    }
    static public func deleteBlog(blog: EventPost, completion: @escaping (Error?) -> Void) {
        DBService.firestoreDB
            .collection(EventPostCollectionKeys.CollectionKey)
            .document(blog.documentId)
            .delete { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    static public func fetchUser(userId: String, completion: @escaping (Error?, PinPointUser?) -> Void) {
        DBService.firestoreDB
            .collection(PinPointUserCollectionKeys.CollectionKey)
            .whereField(PinPointUserCollectionKeys.PinPointUserIdKey, isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(error, nil)
                } else if let snapshot = snapshot?.documents.first {
                    let blogCreator = PinPointUser(dict: snapshot.data())
                    completion(nil, blogCreator)
                }
        }
    }
    static public func fetchBlogCreator(userId: String, completion: @escaping (Error?, PinPointUser?) -> Void) {
        DBService.firestoreDB
            .collection(PinPointUserCollectionKeys.CollectionKey)
            .whereField(PinPointUserCollectionKeys.PinPointUserIdKey, isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(error, nil)
                } else if let snapshot = snapshot?.documents.first {
                    let blogCreator = PinPointUser(dict: snapshot.data())
                    completion(nil, blogCreator)
                }
        }
    }
}
