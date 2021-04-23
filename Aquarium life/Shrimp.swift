//
//  Fish.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 29/11/20.
//

import Foundation

struct Shrimp : Codable, Identifiable, Hashable {
    let id : Int
    let name : String
    let genus : String
    let maxSize : Int
    let minTemp: Int
    let maxTemp: Int
    let minpH: Float
    let maxpH: Float
    let minTankSize: Int
    let description: String
    let care: String
    let reproduction : String
}
