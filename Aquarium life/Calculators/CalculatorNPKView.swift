//
//  CalculatorNPKView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 08/12/20.
//

import SwiftUI

struct CalculatorNPKView: View {
    
    @ObservedObject var textFieldCharsManagerNPK = TextFieldCharsManager()
    
    let units = ["liters","US gallons","UK gallons"]
    @State private var unitSelected = 0
    
    @State private var NPKAlert : Bool = false
    
    @State private var fertiliserWeight = 5.0
    
    @State private var NRatio = 20.0  
    @State private var PRatio = 20.0
    @State private var KRatio = 20.0
    var NPKAdded : Double {
        if NRatio + PRatio + KRatio >= 100.0 {
            NPKAlert = true
            return NRatio + PRatio + KRatio
        }
        return NRatio + PRatio + KRatio
    }
    
    var computedNitrogen : Double  {
        if textFieldCharsManagerNPK.userVolume != Constants.emptyString  && unitSelected == 0 {
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (NRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0 )
            return fertiliserPPM
        }
        else if textFieldCharsManagerNPK.userVolume != Constants.emptyString  && unitSelected == 1 {
            let USGallonsToLiters = (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0 ) * 3.785
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (NRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / USGallonsToLiters
            return fertiliserPPM
        }
        else if textFieldCharsManagerNPK.userVolume != Constants.emptyString  && unitSelected == 2 {
            let UKGallonsToLiters = (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0) * 4.546
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (NRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / UKGallonsToLiters
            return fertiliserPPM
        }
        return 0
    }
    var computedPhosphorus : Double {
        if textFieldCharsManagerNPK.userVolume != Constants.emptyString && unitSelected == 0{
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (PRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0 )
            return fertiliserPPM
        }
        else if textFieldCharsManagerNPK.userVolume != Constants.emptyString  && unitSelected == 1 {
            let USGallonsToLiters = (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0 ) * 3.785
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (PRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / USGallonsToLiters
            return fertiliserPPM
        }
        else if textFieldCharsManagerNPK.userVolume != Constants.emptyString  && unitSelected == 2 {
            let UKGallonsToLiters = (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0) * 4.546
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (PRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / UKGallonsToLiters
            return fertiliserPPM
        }
        
        return 0
    }
    var computedPotassium : Double {
        if textFieldCharsManagerNPK.userVolume != Constants.emptyString && unitSelected == 0 {
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (KRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0 )
            return fertiliserPPM
        }
        else if textFieldCharsManagerNPK.userVolume != Constants.emptyString  && unitSelected == 1 {
            let USGallonsToLiters = (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0 ) * 3.785
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (KRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / USGallonsToLiters
            return fertiliserPPM
        }
        else if textFieldCharsManagerNPK.userVolume != Constants.emptyString  && unitSelected == 2 {
            let UKGallonsToLiters = (Double(textFieldCharsManagerNPK.userVolume) ?? 0.0) * 4.546
            let fertilizerInMilligram = fertiliserWeight * 1000
            let fertiliserPPMPerLitre : Double = fertilizerInMilligram * (KRatio / 100)
            let fertiliserPPM = fertiliserPPMPerLitre / UKGallonsToLiters
            return fertiliserPPM
        }
        return 0
    }
    
    var body: some View {
        Form {
            Section(header: Text(LocalizedStringKey("NPK fertiliser ratio")))
            {
                Picker("Type", selection: $unitSelected) {
                    ForEach(0 ..< units.count) {
                        Text(LocalizedStringKey(self.units[$0]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Group {
                    
                    HStack {
                        Text(LocalizedStringKey("Tank volume ="))
                        if unitSelected == 0 {
                            TextField(LocalizedStringKey("0.0 liters"), text: $textFieldCharsManagerNPK.userVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 1 {
                            TextField(LocalizedStringKey("0.0 US gallons"), text: $textFieldCharsManagerNPK.userVolume)
                                .keyboardType(.decimalPad)
                        }
                        else if unitSelected == 2 {
                            TextField(LocalizedStringKey("0.0 UK gallons"), text: $textFieldCharsManagerNPK.userVolume)
                                .keyboardType(.decimalPad)
                        }
                        
                    }
                    HStack {
                        Group {
                            Text(LocalizedStringKey("N :"))
                                .frame(width : 28)
                            Text("\(NRatio , specifier: Constants.Specifier.zero)")
                                .frame(width : 28)
                            Divider()
                            
                        }
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$NRatio, in: 0...80, step: 0.5, onEditingChanged : { data in
                                let temp = NRatio + PRatio + KRatio
                                if temp >= 100 {
                                    NRatio = 99 - (PRatio + KRatio)
                                    NPKAlert = true
                                    
                                }
                            })
                            Image(systemName: "plus")
                        }
                    }
                    HStack {
                        
                        Group {
                            Text(LocalizedStringKey("P :"))
                                .frame(width : 28)
                            Text("\(PRatio , specifier: Constants.Specifier.zero)")
                                .frame(width : 28)
                            Divider()
                            
                        }
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$PRatio, in: 0...80, step: 0.5, onEditingChanged : { data in
                                let temp = NRatio + PRatio + KRatio
                                if temp >= 100 {
                                    PRatio = 99 - (NRatio + KRatio)
                                    NPKAlert = true
                                    
                                }
                            })
                            Image(systemName: "plus")
                        }
                    }
                    
                    HStack {
                        Group {
                            Text(LocalizedStringKey("K :"))
                                .frame(width : 28)
                            Text("\(KRatio , specifier: Constants.Specifier.zero)")
                                .frame(width : 28)
                            Divider()
                            
                        }
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$KRatio, in: 0...80, step: 0.5, onEditingChanged : { data in
                                let temp = NRatio + PRatio + KRatio
                                if temp >= 100 {
                                    KRatio = 99 - (NRatio + PRatio)
                                    NPKAlert = true
                                    
                                }
                            })
                            Image(systemName: "plus")
                        }
                        
                    }
                    VStack {
                        Group{
                            HStack {
                                Text(LocalizedStringKey("Fertiliser Weight ="))
                                    .frame(width : 140)
                                Group {
                                    Text("\(fertiliserWeight, specifier: Constants.Specifier.zero)")
                                    Text(LocalizedStringKey("gm/"))
                                    Text("\((fertiliserWeight/28.35),specifier: Constants.Specifier.one)")
                                    Text(LocalizedStringKey("oz"))
                                }
                                
                                    //.frame(width : 125)
                            }
                            
                        }
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$fertiliserWeight, in: 0...100, step: 1.0)
                            Image(systemName: "plus")
                        }
                    }
                    
                }
            }
            Section(header: Text(LocalizedStringKey("Fertiliser concentration"))) {
                HStack {
                    Text(LocalizedStringKey("Nitrogen :"))
                    Text("\(computedNitrogen, specifier: Constants.Specifier.zero)")
                    Text(LocalizedStringKey("ppm"))
                }
                HStack {
                    Text(LocalizedStringKey("Phosphorus :"))
                    Text("\(computedPhosphorus, specifier: Constants.Specifier.zero)")
                    Text(LocalizedStringKey("ppm"))
                    
                }
                HStack {
                    Text(LocalizedStringKey("Potassium :"))
                    Text("\(computedPotassium, specifier: Constants.Specifier.zero)")
                    Text(LocalizedStringKey("ppm"))
                    
                }
                
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        self.hideKeyboard()
                    })
            
        }
        
        .alert(isPresented: $NPKAlert) {
            Alert(title: Text(LocalizedStringKey("Value is reset!")), message: Text(LocalizedStringKey("Sum of N, P, K cannot be more than 100")),dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
        }
        .navigationBarTitle(LocalizedStringKey("NPK fertiliser calculator"), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    textFieldCharsManagerNPK.userVolume = ""
                                    fertiliserWeight = 5
                                    NRatio = 20
                                    PRatio = 20
                                    KRatio = 20
                                    
                                }) {
                                    Image(systemName: "gobackward")
                                        .foregroundColor(.green)
                                }
        )
    }
    
}

struct CalculatorNPKView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorNPKView()
    }
}
