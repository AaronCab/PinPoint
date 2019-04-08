//
//  EventPost.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct EventPost {
    let createdDate: String
    let bloggerId: String
    let imageURL: String
    let blogDescription: String
    let documentId: String
    
    init(createdDate: String, bloggerId: String, imageURL: String, blogDescription: String, documentId: String) {
        self.createdDate = createdDate
        self.bloggerId = bloggerId
        self.imageURL = imageURL
        self.blogDescription = blogDescription
        self.documentId = documentId
    }
    
    init(dict: [String: Any]) {
        self.createdDate = dict[EventPostCollectionKeys.CreatedDateKey] as? String ?? "no date"
        self.bloggerId = dict[EventPostCollectionKeys.PinPointUserIdKey] as? String ?? "no blogger id"
        self.imageURL = dict[EventPostCollectionKeys.ImageURLKey] as? String ?? "no imageURL"
        self.blogDescription = dict[EventPostCollectionKeys.EventPostDescritionKey] as? String ?? "no description"
        self.documentId = dict[EventPostCollectionKeys.DocumentIdKey] as? String ?? "no document id"
    }
}
