//
//  Crab.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import Foundation

struct Crab : Codable, Identifiable, Hashable {
    
    let id : Int
    let name : String
    let maxSize : Int
    let temperament : String
    let description : String
    let care : String
    let diet : String
    let minTemp: Int
    let maxTemp: Int
    let minpH: Float
    let maxpH: Float
    
}
