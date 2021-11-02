//
//  GuideDetailView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 29/11/20.
//

import SwiftUI

struct LiveStockShrimpDetailView: View {
    let shrimp : Shrimp
    var body: some View {
        ScrollView(.vertical) {
            
            VStack(alignment: .leading) {
                Text(shrimp.name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text("Genus: ").font(.headline)
                    Text(shrimp.genus)
                        .foregroundColor(.gray).font(.body)
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group{
                    HStack {
                        Text("Maximum size: ").font(.headline)
                        Text("\(shrimp.maxSize)").foregroundColor(.gray).font(.body)
                        Text("inches").foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Care: ").font(.headline)
                        Text("\(shrimp.care)").font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water temperature: ").font(.headline)
                        Text("\(shrimp.minTemp) - \(shrimp.maxTemp)").font(.body).foregroundColor(.gray)
                        Text("°Celsius").font(.body).foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water pH: ").font(.headline)
                        Text("\(shrimp.minpH, specifier :Constants.Specifier.one) - \(shrimp.maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                        
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Minimum aquarium volume: ").font(.headline)
                        Text("\(shrimp.minTankSize)").font(.body).foregroundColor(.gray)
                        Text("liters").font(.body).foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                }
            }
        }
        .navigationBarTitle(Text("Shrimp details"), displayMode: .inline)
    }
}

struct LiveStockShrimpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let shrimp = Shrimp(id: 1, name: "1", genus: "1", maxSize: 1, minTemp: 1, maxTemp: 1, minpH: 1, maxpH: 1, minTankSize: 1, description: "1", care: "1", reproduction: "1")
        LiveStockShrimpDetailView(shrimp: shrimp)
    }
}
