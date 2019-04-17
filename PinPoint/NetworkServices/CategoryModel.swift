//
//  CategoryModel.swift
//  PinPoint
//
//  Created by Genesis Mosquera on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AvailableCategories: Codable {
    let categories: [CategoryOption]
}
struct CategoryOption: Codable {
    let business: String
    let scienceAndTech: String
    let music: String
    let filmAndMedia: String
    let arts: String
    let fashion: String
    let health: String
    let sportsAndFitness: String
    
    
}
