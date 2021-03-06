//
//  EventPost.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import Firebase
struct EventCreatedByUser {
    let location: String
    let createdAt: String
    let personID: String
    let photoURL: String
    let eventDescription: String
    let lat: Double
    let long: Double
    let displayName: String
    let email: String
    let eventType: String
    let isTrustedUser: [String]?
    let message: [String]?
    let documentId: String
    let pending: [String]?
    let startedAt: Timestamp?
    let endDate: Timestamp?
    
    
    init(location: String, createdAt: String, personID: String, photoURL: String, eventDescription: String, lat: Double, long: Double, displayName: String, email: String, isTrustedUser: [String], eventType: String, documentID: String, message: [String], pending: [String], startedAt: Timestamp?, endDate: Timestamp?){
        self.location = location
        self.createdAt = createdAt
        self.personID = personID
        self.photoURL = photoURL
        self.eventDescription = eventDescription
        self.lat = lat
        self.long = long
        self.displayName = displayName
        self.email = email
        self.eventType = eventType
        self.isTrustedUser = isTrustedUser
        self.documentId = documentID
        self.message = message
        self.pending = pending
        self.startedAt = startedAt
        self.endDate = endDate
    }
    init(dict: [String: Any]) {
        self.location = dict[EventCollectionKeys.Location] as? String ?? "No Location Name"
        self.createdAt = dict[EventCollectionKeys.CreatedAt] as? String ?? "No Created Date"
        self.personID = dict[EventCollectionKeys.PersonID] as? String ?? "No one logged in"
        self.photoURL = dict[EventCollectionKeys.PhotoURL] as? String ?? "no Photo"
        self.eventDescription = dict[EventCollectionKeys.EventDescription] as? String ?? "No Description"
        self.lat = dict[EventCollectionKeys.Lat] as? Double ?? 0.0
        self.long = dict[EventCollectionKeys.Long] as? Double ?? 0.0
        self.displayName = dict[EventCollectionKeys.DisplayNameKey] as? String ?? "No DisplayName"
        self.email = dict[EventCollectionKeys.EmailKey] as? String ?? "No email"
        self.isTrustedUser = dict[EventCollectionKeys.IsTrusted] as? [String] ?? [""]
        self.eventType = dict[EventCollectionKeys.EventType] as? String ?? "No event type"
        self.documentId = dict[EventCollectionKeys.DocumentIdKey] as? String ?? "No ID"
        self.message = dict[EventCollectionKeys.Message] as? [String]
        self.pending = dict[EventCollectionKeys.Pending] as? [String]
        self.startedAt = dict[EventCollectionKeys.StartedAt] as? Timestamp
        self.endDate = dict[EventCollectionKeys.EndDate] as? Timestamp
    }
}
