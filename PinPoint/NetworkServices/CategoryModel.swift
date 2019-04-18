//
//  CategoryModel.swift
//  PinPoint
//
//  Created by Genesis Mosquera on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

public class Catagory{
    private init (){}
    
var catagories = [
"Business": "101",
"ScienceAndTech": "102",
"Music": "103",
"FilmAndMedia": "104",
"Arts": "105",
"Fashion": "106",
"Health": "107",
"SportsAndFitness": "108",
    "All": ""]
    var catagoriesInAnArray = ["Business", "ScienceAndTech", "Music","FilmAndMedia","Arts","Fashion", "Health","SportsAndFitness", "All"]
}
extension Dictionary where Value : Equatable {
    func allKeysForValue(val : Value) -> [Key]? {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
