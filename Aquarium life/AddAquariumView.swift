//
//  AddAquariumView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 31/12/20.
//

import SwiftUI

enum ActiveAlert {
    case first, second, third, fourth, zero
}

struct AddAquariumView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .zero
    
    @ObservedObject var textFieldCharsManagerAddTank = TextFieldCharsManager()
    @State private var tankNameValidation : Bool = false
    @State private var lengthValidation : Bool = false
    @State private var widthValidation : Bool = false
    @State private var heightValidation : Bool = false
    
    let units = ["Centimeters","Inches"]
    @State private var unitSelected = 0
    
    let filtrationTypeOptions = ["Internal","Overhead","Canister","Sump"]
    @State private var filtrationTypeSelected = 0
    
    let heaterOptions = ["Yes","No"]
    @State private var heatingOptionSelected = 0
    
    let substrateOptions = ["Sand","Gravel","Soil","Dirted"]
    @State private var substrateOptionSelected = 0
    
    
    var tempComputedVolumeLiters : Double {
        if unitSelected == 0 {
            return computedVolumeLitersFromCM
        }
        else{
            return computedVolumeLitersFromInches
        }
    }
    
    var computedVolumeLitersFromCM : Double {
        let tempUserLength = Double(textFieldCharsManagerAddTank.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerAddTank.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerAddTank.userHeightForVolume) ?? 0
        
        return (tempUserLength * tempUserWidth * tempUserHeight) * 0.001
    }
    
    var computedVolumeLitersFromInches : Double {
        let tempUserLength = Double(textFieldCharsManagerAddTank.userLengthForVolume) ?? 0
        let tempUserWidth = Double(textFieldCharsManagerAddTank.userWidthForVolume) ?? 0
        let tempUserHeight = Double(textFieldCharsManagerAddTank.userHeightForVolume) ?? 0
        
        return (tempUserLength * tempUserWidth * tempUserHeight) * 0.0163871
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("Name"))) {
                    TextField(LocalizedStringKey("egGreenMountain"), text: $textFieldCharsManagerAddTank.userName )
                    
                }
                
                Section(header: Text(LocalizedStringKey("Dimensions")))
                {
                    Picker("Type", selection: $unitSelected) {
                        ForEach(0 ..< units.count) {
                            Text(LocalizedStringKey(self.units[$0]))
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Group {
                        HStack {
                            Text(LocalizedStringKey("Length="))
                            if unitSelected == 0 {
                                TextField(LocalizedStringKey("0.0 centimeters"), text: $textFieldCharsManagerAddTank.userLengthForVolume)
                                    .keyboardType(.decimalPad)
                            }
                            else if unitSelected == 1 {
                                TextField(LocalizedStringKey("0.0 inches"), text: $textFieldCharsManagerAddTank.userLengthForVolume)
                                    .keyboardType(.decimalPad)
                            }
                            
                        }
                        HStack {
                            Text(LocalizedStringKey("Width="))
                            if unitSelected == 0 {
                                TextField(LocalizedStringKey("0.0 centimeters"), text: $textFieldCharsManagerAddTank.userWidthForVolume)
                                    .keyboardType(.decimalPad)
                            }
                            else if unitSelected == 1 {
                                TextField(LocalizedStringKey("0.0 inches"), text: $textFieldCharsManagerAddTank.userWidthForVolume)
                                    .keyboardType(.decimalPad)
                            }
                            
                        }
                        
                        HStack {
                            Text(LocalizedStringKey("Height="))
                            if unitSelected == 0 {
                                TextField(LocalizedStringKey("0.0 centimeters"), text: $textFieldCharsManagerAddTank.userHeightForVolume)
                                    .keyboardType(.decimalPad)
                            }
                            else if unitSelected == 1 {
                                TextField(LocalizedStringKey("0.0 inches"), text: $textFieldCharsManagerAddTank.userHeightForVolume)
                                    .keyboardType(.decimalPad)
                                
                            }
                        }
                    }
                }
                Section(header: Text(LocalizedStringKey("Filtration"))) {
                    Picker("Type", selection: $filtrationTypeSelected) {
                        ForEach(0 ..< filtrationTypeOptions.count) {
                            Text(LocalizedStringKey(self.filtrationTypeOptions[$0]))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                Section(header: Text(LocalizedStringKey("Heater"))) {
                    Picker("Type", selection: $heatingOptionSelected) {
                        ForEach(0 ..< heaterOptions.count) {
                            Text(LocalizedStringKey(self.heaterOptions[$0]))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                Section(header: Text(LocalizedStringKey("Substrate"))) {
                    Picker("Type", selection: $substrateOptionSelected) {
                        ForEach(0 ..< substrateOptions.count) {
                            Text(LocalizedStringKey(self.substrateOptions[$0]))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                Section {}.gesture(
                    TapGesture()
                        .onEnded { _ in
                            self.hideKeyboard()
                        })

        }
        .alert(isPresented: $showAlert){
            switch activeAlert {
            case .first:
                return Alert(title : Text(LocalizedStringKey("NameEmptyAlertTitle")), message: Text(LocalizedStringKey("NameEmptyAlertMsg")), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                
            case .zero:
                return Alert(title : Text("Alert"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                
                
            case .second:
                return Alert(title : Text(LocalizedStringKey("NameLengthAlertTitle")), message: Text(LocalizedStringKey("NameLengthAlertMsg")), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                
            case .third:
                return Alert(title : Text(LocalizedStringKey("NameWidthAlertTitle")), message: Text(LocalizedStringKey("NameWidthAlertMsg")), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                
            case .fourth:
                return Alert(title : Text(LocalizedStringKey("NameHeightAlertTitle")), message: Text(LocalizedStringKey("NameHeightAlertMsg")), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
            }
        }
        .navigationBarTitle(LocalizedStringKey("AddAquarium"), displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text(LocalizedStringKey("DismissButton"))
        } ,trailing: Button(action : {
            saveButton()
        }) {
            Text(LocalizedStringKey("SaveButton"))
        }
        )
    }
    }
    func saveButton(){
        if textFieldCharsManagerAddTank.userName == Constants.emptyString {
            self.activeAlert = .first
            self.showAlert = true
        }
        else if textFieldCharsManagerAddTank.userLengthForVolume == Constants.emptyString {
            self.activeAlert = .second
            self.showAlert = true
        }
        else if textFieldCharsManagerAddTank.userWidthForVolume == Constants.emptyString {
            self.activeAlert = .third
            self.showAlert = true
        }
        else if textFieldCharsManagerAddTank.userHeightForVolume == Constants.emptyString {
            self.activeAlert = .fourth
            self.showAlert = true
        } else {
            let newAquarium = AddAquarium(context: moc)
            
            newAquarium.aquariumName = self.textFieldCharsManagerAddTank.userName
            newAquarium.aquariumDimensionUnits = Int16(self.unitSelected)
            newAquarium.aquariumLength = self.textFieldCharsManagerAddTank.userLengthForVolume
            newAquarium.aquariumWidth = self.textFieldCharsManagerAddTank.userWidthForVolume
            newAquarium.aquariumHeight = self.textFieldCharsManagerAddTank.userHeightForVolume
            newAquarium.externalFiltration = self.filtrationTypeOptions[self.filtrationTypeSelected]
            newAquarium.heater = self.heaterOptions[self.heatingOptionSelected]
            newAquarium.substrate = self.substrateOptions[self.substrateOptionSelected]
            newAquarium.volume = self.tempComputedVolumeLiters
            newAquarium.date = Date()
            newAquarium.id = UUID().uuidString
            
            try? self.moc.save()
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddAquariumView_Previews: PreviewProvider {
    static var previews: some View {
        AddAquariumView()
    }
}
