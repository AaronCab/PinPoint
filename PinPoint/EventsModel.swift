//
//  EventsModel.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct EventsInArea: Codable{
    let events: [Event]
}
struct Event: Codable {
    let name: NameOfEvent?
    let description: DescriptionOfEvent?
    let url: String?
    let start: StartTimeOfEvent?
    let end: EndTimeOfEvent?
    let created: String?
    let changed: String?
    let published: String?
    let capacity: String?
    let status: String?
    let currency: String?
    let logo: LogoOfTheEvent?
    let is_free: Bool?
}
struct NameOfEvent: Codable {
    let text: String?
}
struct DescriptionOfEvent: Codable {
    let text: String?
}
struct StartTimeOfEvent: Codable {
    let timezone: String
    let utc: String
    
}
struct EndTimeOfEvent: Codable {
    let timezone: String
    let utc: String
}
struct LogoOfTheEvent: Codable {
    let original: PictureOfTheEvent
}
struct PictureOfTheEvent: Codable {
    let url: String
}
