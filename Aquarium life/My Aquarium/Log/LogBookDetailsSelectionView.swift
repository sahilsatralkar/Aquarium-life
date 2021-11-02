//
//  LogBookDetailsSelectionView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 17/01/21.
//

import SwiftUI

struct LogBookDetailsSelectionView: View {
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        return formatter
    }()
    
    static let taskTimeFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
            return formatter
        }()
    
    var aquariumLog : AddLog
    
    var body: some View {
        ScrollView(.vertical) {
            
            VStack(alignment: .leading) {
                Text("\(aquariumLog.date ?? Date(), formatter: Self.taskDateFormat)")
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                
                Divider()
                
                Group {
                    HStack {
                        Text("Logging time: ").font(.headline)
                        Text("\(aquariumLog.date ?? Date(), formatter: Self.taskTimeFormat)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water temperature: ").font(.headline)
                        Text("\(aquariumLog.temp, specifier: Constants.Specifier.zero) °Celsius")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Water pH: ").font(.headline)
                        Text("\(aquariumLog.pH, specifier: Constants.Specifier.one)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Ammonia: ").font(.headline)
                        Text("\(aquariumLog.ammonia, specifier: Constants.Specifier.two) ppm or mg/liter")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Nitrites: ").font(.headline)
                        Text("\(aquariumLog.nitrites, specifier: Constants.Specifier.one) ppm or mg/liter")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Nitrates: ").font(.headline)
                        Text("\(aquariumLog.nitrates, specifier: Constants.Specifier.zero) ppm or mg/liter")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    
                }
            }
        }
        .navigationBarTitle("Log details", displayMode: .inline)
    }
}

struct LogBookDetailsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LogBookDetailsSelectionView(aquariumLog: AddLog())
    }
}
