//
//  AquariumSnailSelectedDetails.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI

struct AquariumSnailSelectedDetails: View {
    let snails : [Snail] = Bundle.main.decode(Constants.File.snailJSON)
    let snailArrayIndex : Int
    
    var body: some View {
     
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(snails[snailArrayIndex].name)
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                Divider()
                HStack {
                    Text(LocalizedStringKey("Care: ")).font(.headline)
                    Text(snails[snailArrayIndex].care)
                        .foregroundColor(.gray).font(.body)
                }
                
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 2)
                .padding(.top, 2)
                Group {
                    HStack {
                        Text(LocalizedStringKey("Maximum size: ")).font(.headline)
                        Text("\(snails[snailArrayIndex].maxSize, specifier :Constants.Specifier.one)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("inches")).foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text(LocalizedStringKey("Temperament: ")).font(.headline)
                        Text(snails[snailArrayIndex].temperament)
                            .foregroundColor(.gray).font(.body)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    HStack {
                        Text(LocalizedStringKey("Diet: ")).font(.headline)
                        Text("\(snails[snailArrayIndex].diet)").foregroundColor(.gray).font(.body)
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water temperature: ")).font(.headline)
                        Text("\(snails[snailArrayIndex].minTemp) - \(snails[snailArrayIndex].maxTemp)").foregroundColor(.gray).font(.body)
                        Text(LocalizedStringKey("°Celsius")).foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text(LocalizedStringKey("Water pH: ")).font(.headline)
                        Text("\(snails[snailArrayIndex].minpH, specifier :Constants.Specifier.one) - \(snails[snailArrayIndex].maxpH, specifier :Constants.Specifier.one)")
                            .foregroundColor(.gray).font(.body)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                    
                    
                    
                }
            }
        }
        .navigationBarTitle(Text(LocalizedStringKey("Snail details")), displayMode: .inline)
    }
}


struct AquariumSnailSelectedDetails_Previews: PreviewProvider {
    static var previews: some View {
        AquariumSnailSelectedDetails(snailArrayIndex: 1)
    }
}
