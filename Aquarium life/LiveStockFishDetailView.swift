//
//  GuideDetailView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 29/11/20.
//

import SwiftUI

struct LiveStockFishDetailView: View {
    let fish : Fish
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(fish.name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text("Genus: ").font(.headline)
                    Text(fish.genus)
                        .foregroundColor(.gray).font(.body)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group {
                    HStack {
                        Text("Maximum size: ").font(.headline)
                        Text("\(fish.maxSize)").foregroundColor(.gray).font(.body)
                        Text("inches").foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Reproduction: ").font(.headline)
                        Text("\(fish.reproduction)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Temperament: ").font(.headline)
                        Text(fish.temperament)
                            .foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text("Care: ").font(.headline)
                        Text("\(fish.care)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Diet: ").font(.headline)
                        Text("\(fish.diet)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water temperature: ").font(.headline)
                        Text("\(fish.minTemp) - \(fish.maxTemp)").foregroundColor(.gray).font(.body)
                        Text("°Celsius").foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water pH: ").font(.headline)
                        Text("\(fish.minpH, specifier :Constants.Specifier.one) - \(fish.maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Minimum aquarium volume: ").font(.headline)
                        Text("\(fish.minTankSize)").foregroundColor(.gray).font(.body)
                        Text("liters").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Planted aquarium safe: ").font(.headline)
                        Text("\(fish.plants)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                }
            }
        }
        .navigationBarTitle(Text("Fish details"), displayMode: .inline)
        
    }
}
struct LiveStockFishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let fish = Fish(id: 1, name: "1", genus: "1", maxSize: 1, temperament: "1", minTemp: 1, maxTemp: 1, minpH: 1, maxpH: 1, minTankSize: 1, description: "1", care: "1", reproduction: "1", diet: "1", plants: "1")
        LiveStockFishDetailView(fish: fish)
    }
}
