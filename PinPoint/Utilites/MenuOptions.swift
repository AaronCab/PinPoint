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
    case Moments
    case Messages
    case Profile
    
    var description: String {
        switch self {
        case .Discover: return "Discover"
        case .Moments: return "Moments"
        case .Messages: return "Messages"
        case .Profile: return "Profile"
            
        }
    }
    
    var image: UIImage  {
        switch self {
        case .Discover: return UIImage(named: "icons8-ask-question-25") ?? UIImage()
        case .Moments: return UIImage(named: "icons8-account-25") ?? UIImage()
        case .Messages: return UIImage(named: "icons8-ask-question-25") ?? UIImage()
        case .Profile: return UIImage(named: "icons8-account-25") ?? UIImage()
            
        }
    }
}
