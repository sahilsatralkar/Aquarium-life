//
//  CalculatorWaterChangeView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 08/12/20.
//

import SwiftUI

struct CalculatorWaterChangeView: View {
    
    let units = ["liters","US gallons","UK gallons"]
    @State private var unitSelected = 0
    
    @State private var percentageSliderValue : Double = 20
    
    @ObservedObject var textFieldCharsManager = TextFieldCharsManager()
    
    var computedWaterChange : Double {
        let tempTankVolumeLength = Double(textFieldCharsManager.userVolume) ?? 0
        let tempWaterChangePercent = percentageSliderValue / 100
        
        return (tempTankVolumeLength * tempWaterChangePercent)
    }
    
    var body: some View {
        Form
        {
            // v.1.4
            Section(header: Text(LocalizedStringKey("Water change percentage"))){
            //
                Picker("Units", selection: $unitSelected) {
                    ForEach(0 ..< units.count) {
                        Text(LocalizedStringKey(self.units[$0]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Group {
                    HStack {
                        Text(LocalizedStringKey("Aquarium Volume ="))
                        if unitSelected == 0 {
                            TextField(LocalizedStringKey("0.0 liters"), text: $textFieldCharsManager.userVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField(LocalizedStringKey("0.0 US gallons"), text: $textFieldCharsManager.userVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 2 {
                            TextField(LocalizedStringKey("0.0 UK gallons"), text: $textFieldCharsManager.userVolume)
                                .keyboardType(.decimalPad)
                        }
                    }
                    VStack {
                        
                        HStack {
                            Text(LocalizedStringKey("Water change ="))
                            Text("\(percentageSliderValue, specifier : Constants.Specifier.zero) %")
                            
                        }
                        HStack {
                            
                            Image(systemName: "minus")
                            Slider(value:$percentageSliderValue, in: 0...100, step: 5.0)
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            Section(header: Text(LocalizedStringKey("Fresh water"))) {
                HStack {
                    Text("\(self.computedWaterChange, specifier: Constants.Specifier.two)")
                    
                    if unitSelected == 0 {
                        Text(LocalizedStringKey("liters"))
                        
                    }
                    else if unitSelected == 1 {
                        Text(LocalizedStringKey("US gallons"))
                        
                        
                    }
                    else if unitSelected == 2 {
                        Text(LocalizedStringKey("UK gallons"))
                        
                        
                    }
                }
                
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        self.hideKeyboard()
                    })
        }
        .navigationBarTitle(LocalizedStringKey("Water change calculator"), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    textFieldCharsManager.userVolume = ""
                                    percentageSliderValue = 20
                                    unitSelected = 0
                                }) {
                                    Image(systemName: "gobackward")
                                        .foregroundColor(.green)
                                }
        )
    }
}

struct CalculatorWaterChangeView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorWaterChangeView()
    }
}
