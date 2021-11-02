//
//  AquariumPlantSelectedDetails.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 27/01/21.
//

import SwiftUI

struct AquariumPlantSelectedDetails: View {
    let plants : [Plant] = Bundle.main.decode(Constants.File.plantJSON)
    let plantArrayIndex : Int
    var body: some View {

        
        ScrollView(.vertical) {
            
            VStack(alignment: .leading) {
                Text(plants[plantArrayIndex].name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text(LocalizedStringKey("Type: ")).font(.headline)
                    Text(plants[plantArrayIndex].type).font(.body)
                        .foregroundColor(.gray)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                HStack {
                    Text(LocalizedStringKey("Origin: ")).font(.headline)
                    Text(plants[plantArrayIndex].origin).font(.body)
                        .foregroundColor(.gray)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                HStack {
                    Text(LocalizedStringKey("Maximum height: ")).font(.headline)
                    Text("\(String(plants[plantArrayIndex].maxHeight))").font(.body).foregroundColor(.gray)
                    Text(LocalizedStringKey("inches"))
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group {
                HStack {
                    Text(LocalizedStringKey("Growth rate: ")).font(.headline)
                    Text("\(plants[plantArrayIndex].growth)").font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                
                
                }
                HStack {
                    Text(LocalizedStringKey("Care: ")).font(.headline)
                    Text(plants[plantArrayIndex].care).font(.body)
                        .foregroundColor(.gray)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                HStack {
                    Text(LocalizedStringKey("Light requirement: ")).font(.headline)
                    Text(plants[plantArrayIndex].light).font(.body)
                        .foregroundColor(.gray)
                    
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                
                HStack {
                    Text(LocalizedStringKey("External CO2 required: ")).font(.headline)
                    Text(plants[plantArrayIndex].CO2).font(.body)
                        .foregroundColor(.gray)
                    
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
            }
        }
        .navigationBarTitle(Text(LocalizedStringKey("Plant details")), displayMode: .inline)
    }
}

struct AquariumPlantSelectedDetails_Previews: PreviewProvider {
    static var previews: some View {
        AquariumPlantSelectedDetails(plantArrayIndex: 1)
    }
}
