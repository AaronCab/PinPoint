//
//  MenuOptions.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case Discover
    case Nearby
    case Favorites
    case Preferences
    case Requests
    case Profile
    
    var description: String {
        switch self {
        case .Discover: return "Discover"
        case .Nearby: return "Nearby Events"
        case .Favorites: return "Favorites"
        case .Preferences: return "Preferences"
        case .Requests: return "Friend Requests"
        case .Profile: return "Profile"
            
        }
    }
    
    var image: UIImage  {
        switch self {
        case .Discover: return UIImage(named: "icons8-today-240.png") ?? UIImage()
        case .Nearby: return UIImage(named: "icons8-map-80") ?? UIImage()
        case .Favorites: return UIImage(named: "icons8-star-80.png") ?? UIImage()
        case .Preferences: return UIImage(named: "icons8-map-pinpoint-80.png") ?? UIImage()
        case .Requests: return UIImage(named: "icons8-chat-51") ?? UIImage()
        case .Profile: return UIImage(named: "icons8-customer-240.png") ?? UIImage()
            
            
        }
    }
}
