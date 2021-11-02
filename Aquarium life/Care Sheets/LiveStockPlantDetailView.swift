//
//  GuideDetailView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 29/11/20.
//

import SwiftUI

struct LiveStockPlantDetailView: View {
    let plant : Plant
    var body: some View {
        ScrollView(.vertical) {
            
            VStack(alignment: .leading) {
                Text(plant.name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text("Type: ").font(.headline)
                    Text(plant.type).font(.body)
                        .foregroundColor(.gray)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                HStack {
                    Text("Origin: ").font(.headline)
                    Text(plant.origin).font(.body)
                        .foregroundColor(.gray)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                HStack {
                    Text("Maximum height: ").font(.headline)
                    Text("\(String(plant.maxHeight))").font(.body).foregroundColor(.gray)
                    Text("inches").font(.body).foregroundColor(.gray)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group {
                HStack {
                    Text("Growth rate: ").font(.headline)
                    Text("\(plant.growth)").font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                
                
                }
                HStack {
                    Text("Care: ").font(.headline)
                    Text(plant.care).font(.body)
                        .foregroundColor(.gray)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                HStack {
                    Text("Light requirement: ").font(.headline)
                    Text(plant.light).font(.body)
                        .foregroundColor(.gray)
                    
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                
                HStack {
                    Text("External CO2 required: ").font(.headline)
                    Text(plant.CO2).font(.body)
                        .foregroundColor(.gray)
                    
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
            }
        }
        .navigationBarTitle(Text("Plant details"), displayMode: .inline)
    }
}

struct LiveStockPlantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let plant = Plant(id: 1, name: "", type: "", origin: "", growth: "", maxHeight: 1, care: "", light: "", CO2: "", description: "")
        LiveStockPlantDetailView(plant: plant)
    }
}
