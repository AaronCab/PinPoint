//
//  Date+Extensions.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import Firebase
extension Date {
    // get an ISO timestamp
    static func getISOTimestamp() -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        let timestamp = isoDateFormatter.string(from: Date())
        return timestamp
    }
}
extension Timestamp{
    
}
