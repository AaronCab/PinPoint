//
//  EventsCalendarModel.swift
//  PinPoint
//
//  Created by Genesis Mosquera on 4/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class EventsDataModel {
    private static let filename = "EventCalendarData.plist"
    private static var eventsInfo = [EventCalendarData]()
    static func getEventData() -> [EventCalendarData] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    eventsInfo = try PropertyListDecoder().decode([EventCalendarData].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        eventsInfo = eventsInfo.sorted {$0.date > $1.date}
        return eventsInfo
    }
    
    static func addEvent(event: EventCalendarData) {
        eventsInfo.append(event)
        save()
    }
    static func delete(event: EventCalendarData, atIndex index: Int) {
        eventsInfo.remove(at: index)
        save()
    }
    
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(eventsInfo)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }
    
    static func updateEvent(updatedEvent: EventCalendarData, atIndex index: Int) {
        eventsInfo[index] = updatedEvent
        save()
    }
    
}

