//
//  CategoryModel.swift
//  PinPoint
//
//  Created by Genesis Mosquera on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

public class Category{
    private init (){}
    
var categories = [
"Business": "101",
"Science & Tech": "102",
"Music": "103",
"Film & Media": "104",
"Arts": "105",
"Fashion": "106",
"Health": "107",
"Sports & Fitness": "108",
    "All": ""]
    
    var categoriesInAnArray = ["Business", "Science & Tech", "Music","Film & Media","Arts","Fashion", "Health","Sports & Fitness", "All"]
}
extension Dictionary where Value : Equatable {
    func allKeysForValue(val : Value) -> [Key]? {
        return self.filter { $1 == val }.map { $0.0 }
    }
}


