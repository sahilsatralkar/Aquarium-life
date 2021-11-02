//
//  AquariumShrimpSelectedDetails.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 27/01/21.
//

import SwiftUI

struct AquariumShrimpSelectedDetails: View {
    let shrimps : [Shrimp] = Bundle.main.decode(Constants.File.shrimpJSON)
    let shrimpArrayIndex : Int
    var body: some View {

        ScrollView(.vertical) {
            
            VStack(alignment: .leading) {
                Text(shrimps[shrimpArrayIndex].name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text(LocalizedStringKey("Genus: ")).font(.headline)
                    Text(shrimps[shrimpArrayIndex].genus)
                        .foregroundColor(.gray).font(.body)
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group{
                    HStack {
                        Text(LocalizedStringKey("Maximum size: ")).font(.headline)
                        Text("\(shrimps[shrimpArrayIndex].maxSize)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("inches")).foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)

                    HStack {
                        Text(LocalizedStringKey("Care: ")).font(.headline)
                        Text("\(shrimps[shrimpArrayIndex].care)").font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water temperature: ")).font(.headline)
                        Text("\(shrimps[shrimpArrayIndex].minTemp) - \(shrimps[shrimpArrayIndex].maxTemp)").font(.body).foregroundColor(.gray)
                        Text(LocalizedStringKey("°Celsius")).font(.body).foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water pH: ")).font(.headline)
                        Text("\(shrimps[shrimpArrayIndex].minpH, specifier :Constants.Specifier.one) - \(shrimps[shrimpArrayIndex].maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                        
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Minimum aquarium volume: ")).font(.headline)
                        Text("\(shrimps[shrimpArrayIndex].minTankSize)").font(.body).foregroundColor(.gray)
                        Text(LocalizedStringKey("liters")).font(.body).foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                }
            }
        }
        .navigationBarTitle(Text(LocalizedStringKey("Shrimp details")), displayMode: .inline)
    }
}

struct AquariumShrimpSelectedDetails_Previews: PreviewProvider {
    static var previews: some View {
        AquariumShrimpSelectedDetails(shrimpArrayIndex: 1)
    }
}
