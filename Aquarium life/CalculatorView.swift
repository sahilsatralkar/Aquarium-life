//
//  CalculatorView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import SwiftUI
import AudioToolbox

class TextFieldCharsManager: ObservableObject {
    
    let characterLimit = 4
    let characterLimitForName = 30
    
    @Published var userName = Constants.emptyString {
        didSet {
            if userName.count > characterLimitForName {
                userName = String(userName.prefix(characterLimitForName))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
    
    @Published var userVolume = Constants.emptyString {
        didSet {
            if userVolume.count > characterLimit {
                userVolume = String(userVolume.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
    
    @Published var userLengthForVolume = Constants.emptyString {
        didSet {
            if userLengthForVolume.count > characterLimit {
                userLengthForVolume = String(userLengthForVolume.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
    
    @Published var userWidthForVolume = Constants.emptyString {
        didSet {
            if userWidthForVolume.count > characterLimit {
                userWidthForVolume = String(userWidthForVolume.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
    
    @Published var userHeightForVolume = Constants.emptyString {
        didSet {
            if userHeightForVolume.count > characterLimit {
                userHeightForVolume = String(userHeightForVolume.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
    @Published var userHeight2ForVolume = Constants.emptyString {
        didSet {
            if userHeight2ForVolume.count > characterLimit {
                userHeight2ForVolume = String(userHeight2ForVolume.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
}


struct CalculatorView: View {
    
    
    //Tank volume variables
    @State private var userLengthForVolume = Constants.emptyString
    @State private var userWidthForVolume = Constants.emptyString
    @State private var userHeightForVolume = Constants.emptyString
    var computedPropertyTankVolume : Double {
        let tempUserLength = Double(userLengthForVolume) ?? 0
        let tempUserWidth = Double(userWidthForVolume) ?? 0
        let tempUserHeight = Double(userHeightForVolume) ?? 0
        
        return tempUserLength * tempUserWidth * tempUserHeight
    }
    
    //Substrate calculator variables
    @State private var userLengthForSubstrate = Constants.emptyString
    @State private var userWidthForSubstrate = Constants.emptyString
    @State private var userDesiredSubstrate = Constants.emptyString
    var computedPropertySubstrateVolume : Double {
        let tempUserLength = Double(userLengthForSubstrate) ?? 0
        let tempUserWidth = Double(userWidthForSubstrate) ?? 0
        let tempUserHeight = Double(userDesiredSubstrate) ?? 0
        
        return tempUserLength * tempUserWidth * tempUserHeight
    }
    
    //
    
    @State var userValueInKilograms = Constants.emptyString
    @State private var calculatorSelected = 0
    
    let calculatorSelection = ["Volume calculator", "Substrate calculator", "Water change calculator","Carbon dioxide calculator", "NPK fertiliser calculator", "Light calculator","Carbonate converter","Hardness converter"]
    
    //another varable declared to compute the result.
    var computedValueInPounds : Double {
        //Typecasting userValueInKilograms to Double and also nill coalescence so if user inputs string it wont crash the app.
        let tempUserValueInKilograms = Double(userValueInKilograms) ?? 0
        let tempComputedValueInPounds = (tempUserValueInKilograms * 2.20462262185)
        return tempComputedValueInPounds
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section(header:Text(LocalizedStringKey("Selection"))) {
                    
                    //Tank Volume calculator
                    NavigationLink(
                        destination: CalculatorVolumeView()){
                        Image(systemName: "1.circle")
                            .foregroundColor(.green)
                        Text(LocalizedStringKey(calculatorSelection[0]))
                    }
                    
                    //Substrate calculator
                    NavigationLink(
                        destination: CalculatorSubstrateView()){
                        Image(systemName: "2.circle")
                            .foregroundColor(.green)
                        Text(LocalizedStringKey(calculatorSelection[1]))
                        
                    }
                    //Water change calculator
                    NavigationLink(
                        destination: CalculatorWaterChangeView()){
                        Image(systemName: "3.circle")
                            .foregroundColor(.green)
                        Text(LocalizedStringKey(calculatorSelection[2]))
                    }
                    
                    //Dissolved CO2 calculator
                    NavigationLink(
                        destination: CalculatorCO2View()){
                        Image(systemName: "4.circle")
                            .foregroundColor(.green)
                        Text(LocalizedStringKey(calculatorSelection[3]))
                        
                    }
                    //NPK calculator
                    NavigationLink(
                        destination: CalculatorNPKView()){
                        Image(systemName: "5.circle")
                            .foregroundColor(.green)
                        Text(LocalizedStringKey(calculatorSelection[4]))
                    }

                }
            }
            .navigationBarTitle(LocalizedStringKey("Calculators"))
            
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
