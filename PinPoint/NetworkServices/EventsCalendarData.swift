//
//  EventsCalendarData.swift
//  PinPoint
//
//  Created by Genesis Mosquera on 4/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct EventCalendarData: Codable, Equatable {
    let description: String
    let createdAt: String
    
    init(description: String, createdAt: String) {
        self.description = description
        self.createdAt = createdAt
    }
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = createdAt
        if let date = isoDateFormatter.date(from: createdAt) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    public var date: Date {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
        if let date = isoDateFormatter.date(from: createdAt) {
            formattedDate = date
        }
        return formattedDate
    }
}
