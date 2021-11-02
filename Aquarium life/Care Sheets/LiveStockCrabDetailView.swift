//
//  LiveStockCrabDetailView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI

struct LiveStockCrabDetailView: View {
    let crab : Crab
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(crab.name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                
                Group {
                    HStack {
                        Text("Maximum size: ").font(.headline)
                        Text("\(crab.maxSize)").foregroundColor(.gray).font(.body)
                        Text("inches").foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text("Temperament: ").font(.headline)
                        Text(crab.temperament)
                            .foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text("Care: ").font(.headline)
                        Text("\(crab.care)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Diet: ").font(.headline)
                        Text("\(crab.diet)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water temperature: ").font(.headline)
                        Text("\(crab.minTemp) - \(crab.maxTemp)").foregroundColor(.gray).font(.body)
                        Text("°Celsius").foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water pH: ").font(.headline)
                        Text("\(crab.minpH, specifier :Constants.Specifier.one) - \(crab.maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                }
            }
        }
        .navigationBarTitle(Text("Crab details"), displayMode: .inline)
        
    }
}
struct LiveStockCrabDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let crab = Crab(id: 1, name: "SnailName", maxSize: Int(3.0), temperament: "Peaceful", description: "", care: "Easy", diet: "Omnivore", minTemp: 22, maxTemp: 28, minpH: 6.0, maxpH: 7.5)
        LiveStockCrabDetailView(crab: crab)
    }
}

