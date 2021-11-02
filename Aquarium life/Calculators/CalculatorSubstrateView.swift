//
//  CalculatorSubstrateView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 08/12/20.
//

import SwiftUI

struct CalculatorSubstrateView: View {
    
    @ObservedObject var textFieldCharsManagerSubstrate = TextFieldCharsManager()
    
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
        let tempUserLength = Double(textFieldCharsManagerSubstrate.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerSubstrate.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerSubstrate.userHeightForVolume) ?? 0
        let tempUserHeight2 = Double(textFieldCharsManagerSubstrate.userHeight2ForVolume) ?? 0
        
        var avgHeight : Double = 0
        
        if ( tempUserHeight != 0 && tempUserHeight2 != 0){
            avgHeight = (tempUserHeight + tempUserHeight2) / 2
        }
        
        return (tempUserLength * tempUserWidth * avgHeight ) * 0.001
    }
    
    var computedVolumeUSGallonsFromCM : Double {
        let tempUserLength = Double(textFieldCharsManagerSubstrate.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerSubstrate.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerSubstrate.userHeightForVolume) ?? 0
        let tempUserHeight2 = Double(textFieldCharsManagerSubstrate.userHeight2ForVolume) ?? 0
        var avgHeight : Double = 0
        
        if ( tempUserHeight != 0 && tempUserHeight2 != 0){
            avgHeight = (tempUserHeight + tempUserHeight2) / 2
        }
        
        
        return (tempUserLength * tempUserWidth * avgHeight ) * 0.000264172
    }
    
    var computedVolumeUKGallonsFromCM : Double {
        
        return computedVolumeUSGallonsFromCM * 0.832674
    }
    
    var computedVolumeLitersFromInches : Double {
        let tempUserLength = Double(textFieldCharsManagerSubstrate.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerSubstrate.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerSubstrate.userHeightForVolume) ?? 0
        let tempUserHeight2 = Double(textFieldCharsManagerSubstrate.userHeight2ForVolume) ?? 0
        
        var avgHeight : Double = 0
        
        if ( tempUserHeight != 0 && tempUserHeight2 != 0){
            avgHeight = (tempUserHeight + tempUserHeight2) / 2
        }
        
        return (tempUserLength * tempUserWidth * avgHeight) * 0.0163871
    }
    
    var computedVolumeUSGallonsFromInches : Double {
        let tempUserLength = Double(textFieldCharsManagerSubstrate.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerSubstrate.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerSubstrate.userHeightForVolume) ?? 0
        let tempUserHeight2 = Double(textFieldCharsManagerSubstrate.userHeight2ForVolume) ?? 0
        
        var avgHeight : Double = 0
        
        if ( tempUserHeight != 0 && tempUserHeight2 != 0){
            avgHeight = (tempUserHeight + tempUserHeight2) / 2
        }
        
        return (tempUserLength * tempUserWidth * avgHeight) * 0.004329
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
                            TextField(LocalizedStringKey("0.0 centimeters"), text: $textFieldCharsManagerSubstrate.userLengthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField(LocalizedStringKey("0.0 inches"), text: $textFieldCharsManagerSubstrate.userLengthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        
                    }
                    HStack {
                        HStack {
                            Text(LocalizedStringKey("Width"))
                            Text("=")
                        }
                        if unitSelected == 0 {
                            TextField(LocalizedStringKey("0.0 centimeters"), text: $textFieldCharsManagerSubstrate.userWidthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField(LocalizedStringKey("0.0 inches"), text: $textFieldCharsManagerSubstrate.userWidthForVolume)
                                .keyboardType(.decimalPad)
                        }
                        
                    }
                    
                    HStack {
                        HStack {
                            Text(LocalizedStringKey("Front depth"))
                            Text("=")
                        }
                        if unitSelected == 0 {
                            TextField(LocalizedStringKey("0.0 centimeters"), text: $textFieldCharsManagerSubstrate.userHeightForVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField(LocalizedStringKey("0.0 inches"), text: $textFieldCharsManagerSubstrate.userHeightForVolume)
                                .keyboardType(.decimalPad)
                            
                        }
                    }
                    HStack {
                        HStack {
                            Text(LocalizedStringKey("Rear depth"))
                            Text("=")
                        }
                        if unitSelected == 0 {
                            TextField(LocalizedStringKey("0.0 centimeters"), text: $textFieldCharsManagerSubstrate.userHeight2ForVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField(LocalizedStringKey("0.0 inches"), text: $textFieldCharsManagerSubstrate.userHeight2ForVolume)
                                .keyboardType(.decimalPad)
                            
                        }
                    }
                }
            }
            
            Section(header: Text(LocalizedStringKey("Substrate Volume"))) {
                
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
        .navigationBarTitle("Substrate calculator", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    textFieldCharsManagerSubstrate.userLengthForVolume = ""
                                    textFieldCharsManagerSubstrate.userWidthForVolume = ""
                                    textFieldCharsManagerSubstrate.userHeightForVolume = ""
                                    textFieldCharsManagerSubstrate.userHeight2ForVolume = ""
                                    unitSelected = 0
                                    
                                }) {
                                    Image(systemName: "gobackward")
                                        .foregroundColor(.green)
                                }
        )
    }
}


struct CalculatorSubstrateView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorSubstrateView()
    }
}
