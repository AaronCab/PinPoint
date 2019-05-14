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
    case Requests
    case Profile
    
    var description: String {
        switch self {
        case .Discover: return "PinPoint Events"
        case .Nearby: return "Nearby Events"
        case .Favorites: return "Saved Events"
        case .Requests: return "Friends"
        case .Profile: return "Profile"
            
        }
    }
    
    var image: UIImage  {
        switch self {
        case .Discover: return UIImage(named: "icons8-planner-100") ?? UIImage()
        case .Nearby: return UIImage(named: "icons8-target-100") ?? UIImage()
        case .Favorites: return UIImage(named: "icons8-star-100") ?? UIImage()
        case .Requests: return UIImage(named: "icons8-ok-100") ?? UIImage()
        case .Profile: return UIImage(named: "icons8-contact-100") ?? UIImage()
            
            
        }
    }
}
