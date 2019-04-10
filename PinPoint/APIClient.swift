//
//  APIClient.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
final class ApiClient {
    
    static func getEvents(distance: String, location: String, completionHandler: @escaping (AppError?, [Event]?) -> Void) {
        let secretToken = "HGCVIXQ3FJZNEZUHE4G2"
        let endpointURLString = "https://www.eventbriteapi.com/v3/events/search?location.within=\(distance)&expand=venue-H'Authorization:BearerPERSONAL_OAUTH_TOKEN'&location.address=\(location)&token=\(secretToken)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: endpointURLString) { (error, data) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
            } else if let data = data {
                do {
                    let events = try JSONDecoder().decode(EventsInArea.self, from: data)
                    completionHandler(nil, events.events)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
        
}
}
