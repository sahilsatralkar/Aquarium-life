//
//  Fish.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 29/11/20.
//

import Foundation

struct Plant : Codable, Identifiable, Hashable {
    let id : Int
    let name : String
    let type : String
    let origin: String
    let growth: String
    let maxHeight : Int
    let care: String
    let light: String
    let CO2 : String
    let description : String
    
}
