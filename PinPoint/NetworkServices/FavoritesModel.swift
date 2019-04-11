//
//  FavoritesModel.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct FavoritesModel: Codable {
    let name: String
    let description: String
    let url: String?
    let start: String
    let end: String
    let capacity: String?
    let status: String?
}
