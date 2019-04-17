//
//  CategoryModel.swift
//  PinPoint
//
//  Created by Genesis Mosquera on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class Catagory{
public var catagories = [
"business": "101",
"scienceAndTech": "102",
"music": "103",
"filmAndMedia": "104",
"arts": "105",
"fashion": "106",
"health": "107",
"sportsAndFitness": "108"]
}
extension Dictionary where Value : Equatable {
    func allKeysForValue(val : Value) -> [Key]? {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
