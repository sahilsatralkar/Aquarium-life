//
//  LiveStockSnailDetailView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI

struct LiveStockSnailDetailView: View {
    let snail : Snail
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(snail.name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                
                Group {
                    HStack {
                        Text("Maximum size: ").font(.headline)
                        Text("\(snail.maxSize, specifier :Constants.Specifier.two)").foregroundColor(.gray).font(.body)
                        Text("inches").foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text("Temperament: ").font(.headline)
                        Text(snail.temperament)
                            .foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text("Care: ").font(.headline)
                        Text("\(snail.care)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Diet: ").font(.headline)
                        Text("\(snail.diet)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water temperature: ").font(.headline)
                        Text("\(snail.minTemp) - \(snail.maxTemp)").foregroundColor(.gray).font(.body)
                        Text("°Celsius").foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water pH: ").font(.headline)
                        Text("\(snail.minpH, specifier :Constants.Specifier.one) - \(snail.maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                }
            }
        }
        .navigationBarTitle(Text("Snail details"), displayMode: .inline)
        
    }
}
struct LiveStockSnailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let snail = Snail(id: 1, name: "SnailName", maxSize: 3.0, temperament: "Peaceful", description: "", care: "Easy", diet: "Omnivore", minTemp: 22, maxTemp: 28, minpH: 6.0, maxpH: 7.5)
        LiveStockSnailDetailView(snail: snail)
    }
}

