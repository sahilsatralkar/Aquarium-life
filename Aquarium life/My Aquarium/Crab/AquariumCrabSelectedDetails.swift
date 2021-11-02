//
//  AquariumCrabSelectedDetails.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI

struct AquariumCrabSelectedDetails: View {
    let crabs : [Crab] = Bundle.main.decode(Constants.File.crabJSON)
    let crabArrayIndex : Int
    
    var body: some View {
     
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(crabs[crabArrayIndex].name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text(LocalizedStringKey("Care: ")).font(.headline)
                    Text(crabs[crabArrayIndex].care)
                        .foregroundColor(.gray).font(.body)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group {
                    HStack {
                        Text(LocalizedStringKey("Maximum size: ")).font(.headline)
                        Text("\(crabs[crabArrayIndex].maxSize)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("inches")).foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text(LocalizedStringKey("Temperament: ")).font(.headline)
                        Text(crabs[crabArrayIndex].temperament)
                            .foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text(LocalizedStringKey("Diet: ")).font(.headline)
                        Text("\(crabs[crabArrayIndex].diet)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water temperature: ")).font(.headline)
                        Text("\(crabs[crabArrayIndex].minTemp) - \(crabs[crabArrayIndex].maxTemp)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("°Celsius")).foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water pH: ")).font(.headline)
                        Text("\(crabs[crabArrayIndex].minpH, specifier :Constants.Specifier.one) - \(crabs[crabArrayIndex].maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    
                    
                    
                }
            }
        }
        .navigationBarTitle(Text(LocalizedStringKey("Crab details")), displayMode: .inline)
    }
}


struct AquariumCrabSelectedDetails_Previews: PreviewProvider {
    static var previews: some View {
        AquariumCrabSelectedDetails(crabArrayIndex: 1)
    }
}

