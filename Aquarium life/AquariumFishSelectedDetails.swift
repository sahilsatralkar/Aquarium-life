//
//  AquariumFIshSelectedDetails.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 27/01/21.
//

import SwiftUI

struct AquariumFishSelectedDetails: View {
    
    let fishes : [Fish] = Bundle.main.decode(Constants.File.fishJSON)
    let fishArrayIndex : Int
    
    var body: some View {
     
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(fishes[fishArrayIndex].name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text(LocalizedStringKey("Genus: ")).font(.headline)
                    Text(fishes[fishArrayIndex].genus)
                        .foregroundColor(.gray).font(.body)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group {
                    HStack {
                        Text(LocalizedStringKey("Maximum size: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].maxSize)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("inches")).foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Reproduction: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].reproduction)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Temperament: ")).font(.headline)
                        Text(fishes[fishArrayIndex].temperament)
                            .foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text(LocalizedStringKey("Care: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].care)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Diet: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].diet)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water temperature: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].minTemp) - \(fishes[fishArrayIndex].maxTemp)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("°Celsius")).foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water pH: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].minpH, specifier :Constants.Specifier.one) - \(fishes[fishArrayIndex].maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Minimum aquarium volume: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].minTankSize)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("liters")).foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text(LocalizedStringKey("Planted aquarium safe: ")).font(.headline)
                        Text("\(fishes[fishArrayIndex].plants)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                }
            }
        }
        .navigationBarTitle(Text(LocalizedStringKey("Fish details")), displayMode: .inline)
    }
}

struct AquariumFishSelectedDetails_Previews: PreviewProvider {
    static var previews: some View {
        AquariumFishSelectedDetails(fishArrayIndex: 1)
    }
}
