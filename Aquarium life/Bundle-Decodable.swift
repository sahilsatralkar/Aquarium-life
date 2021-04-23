//
//  Bundle-Decodable.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 18/11/20.
//

import Foundation

//Extension to Bundle which will fetch the JSON values into its structs.
extension Bundle {
    //decode function is made generic
    func decode<T: Codable> ( _ file : String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        return loaded
    }
}
