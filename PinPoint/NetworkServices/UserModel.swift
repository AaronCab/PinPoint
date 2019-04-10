//
//  UserModel.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct UserModel: Codable {
    let name: String
    let lat: Double
    let long: Double
    let photo: String
    let interst1: String
    let interest2: String
    let interest3: String
    let interest4: String
    let interest5: String
}
