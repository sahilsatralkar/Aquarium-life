//
//  CalculatorVolumeView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 08/12/20.
//

import SwiftUI

struct CalculatorVolumeView: View {
    
    @ObservedObject var textFieldCharsManagerVolume = TextFieldCharsManager()
    
    let units = ["Centimeters","Inches"]
    @State private var unitSelected = 0
    
    var tempComputedVolumeLiters : Double {
        if unitSelected == 0 {
            return computedVolumeLitersFromCM
        }
        else{
            return computedVolumeLitersFromInches
        }
    }
    var tempComputedVolumeUSGallons : Double {
        if unitSelected == 0 {
            return computedVolumeUSGallonsFromCM
        }
        else {
            return computedVolumeUSGallonsFromInches
        }
        
    }
    var tempComputedVolumeUKGallons : Double {
        if unitSelected == 0 {
            return computedVolumeUKGallonsFromCM
        }
        else {
            return computedVolumeUKGallonsFromInches
        }
        
    }
    
    var computedVolumeLitersFromCM : Double {
        let tempUserLength = Double(textFieldCharsManagerVolume.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerVolume.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerVolume.userHeightForVolume) ?? 0
        
        return (tempUserLength * tempUserWidth * tempUserHeight) * 0.001
    }
    
    var computedVolumeUSGallonsFromCM : Double {
        let tempUserLength = Double(textFieldCharsManagerVolume.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerVolume.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerVolume.userHeightForVolume) ?? 0
        
        return (tempUserLength * tempUserWidth * tempUserHeight) * 0.000264172
    }
    
    var computedVolumeUKGallonsFromCM : Double {
        
        return computedVolumeUSGallonsFromCM * 0.832674
    }
    
    var computedVolumeLitersFromInches : Double {
        let tempUserLength = Double(textFieldCharsManagerVolume.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerVolume.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerVolume.userHeightForVolume) ?? 0
        
        return (tempUserLength * tempUserWidth * tempUserHeight) * 0.0163871
    }
    
    var computedVolumeUSGallonsFromInches : Double {
        let tempUserLength = Double(textFieldCharsManagerVolume.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerVolume.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerVolume.userHeightForVolume) ?? 0
        
        return (tempUserLength * tempUserWidth * tempUserHeight) * 0.004329
    }
    
    var computedVolumeUKGallonsFromInches : Double {
        
        return computedVolumeUSGallonsFromInches * 0.832674
    }
    
    var body: some View {
        Form {
            Section(header: Text(LocalizedStringKey("Dimensions")))
            {
                Picker("Units", selection: $unitSelected) {
                    ForEach(0 ..< units.count) {
                        Text(LocalizedStringKey(self.units[$0]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Group {
                    HStack {
                        HStack {
                            Text(LocalizedStringKey("Length"))
                            Text("=")
                        }
                        if unitSelected == 0 {
                            TextField("0.0 centimeters", text: $textFieldCharsManagerVolume.userLengthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField("0.0 inches", text: $textFieldCharsManagerVolume.userLengthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        
                    }
                    HStack {
                        HStack {
                            Text(LocalizedStringKey("Width"))
                            Text("=")
                        }
                        if unitSelected == 0 {
                            TextField("0.0 centimeters", text: $textFieldCharsManagerVolume.userWidthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField("0.0 inches", text: $textFieldCharsManagerVolume.userWidthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        
                    }
                    
                    HStack {
                        HStack {
                            Text(LocalizedStringKey("Height"))
                            Text("=")
                        }
                        if unitSelected == 0 {
                            TextField("0.0 centimeters", text: $textFieldCharsManagerVolume.userHeightForVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField("0.0 inches", text: $textFieldCharsManagerVolume.userHeightForVolume)
                                .keyboardType(.decimalPad)
                            
                        }
                    }
                }
            }
            
            Section(header: Text(LocalizedStringKey("Volume"))) {
                
                HStack {
                    Text("\(tempComputedVolumeLiters, specifier: Constants.Specifier.two)")
                    Text(LocalizedStringKey("liters"))

                }
                HStack {
                    Text("\(tempComputedVolumeUSGallons, specifier: Constants.Specifier.two)" )
                    Text(LocalizedStringKey("US gallons"))
                }
                HStack {
                    Text("\(tempComputedVolumeUKGallons, specifier: Constants.Specifier.two)" )
                    Text(LocalizedStringKey("UK gallons"))
                }
                
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        self.hideKeyboard()
                    })
            
        }
        .navigationBarTitle(LocalizedStringKey("Volume calculator"),displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    textFieldCharsManagerVolume.userLengthForVolume = Constants.emptyString
                                    textFieldCharsManagerVolume.userWidthForVolume = Constants.emptyString
                                    textFieldCharsManagerVolume.userHeightForVolume = Constants.emptyString
                                    unitSelected = 0
                                    }) {
                                    Image(systemName: "gobackward")
                                        .foregroundColor(.green)
                                    }
                                )
    }
}

struct CalculatorVolumeView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorVolumeView()
    }
}
