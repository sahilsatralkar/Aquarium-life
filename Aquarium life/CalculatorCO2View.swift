//
//  CalculatorCO2View.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 08/12/20.
//

import SwiftUI

struct CalculatorCO2View: View {
    
    let pHValues = [6.0 ,6.1 ,6.2 ,6.3 ,6.4 ,6.5 ,6.6 ,6.7 ,6.8 ,6.9 ,7.0 ,7.1 ,7.2 ,7.3 ,7.4 ,7.5 ,7.6 ,7.7 ,7.8 ,7.9 ,8.0]
    
    let cO2Chart = [ [30 ,24 ,19 ,16 ,12 ,10 ,8  ,6  ,5 ,4 ,3 ,3 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1],
                     [60 ,48 ,38 ,31 ,24 ,19 ,16 ,12 ,10,8 ,6 ,5 ,4 ,4 ,3 ,2 ,2 ,2 ,1 ,1 ,1],
                     [90 ,72 ,57 ,46 ,36 ,29 ,23 ,18 ,15,12,9 ,8 ,6 ,5 ,4 ,3 ,3 ,2 ,2 ,2 ,1],
                     [120,96 ,76 ,61 ,48 ,38 ,31 ,24 ,20,16,12,10,8 ,7 ,5 ,4 ,4 ,3 ,2 ,2 ,2],
                     [150,120,95 ,76 ,60 ,48 ,38 ,30 ,24,19,15,12,10,8 ,6 ,5 ,4 ,3 ,3 ,2 ,2],
                     [180,143,114,91 ,72 ,57 ,46 ,36 ,29,23,18,15,12,10,8 ,6 ,5 ,4 ,3 ,3 ,2],
                     [210,167,133,106,84 ,67 ,53 ,42 ,34,27,21,17,14,11,9 ,7 ,6 ,5 ,4 ,3 ,3],
                     [240,191,152,121,96 ,76 ,61 ,48 ,39,31,24,20,16,13,10,8 ,7 ,5 ,4 ,4 ,3],
                     [270,215,171,136,108,86 ,68 ,54 ,43,34,27,22,18,14,11,9 ,7 ,6 ,5 ,4 ,3],
                     [300,239,190,151,120,95 ,76 ,60 ,48,38,30,24,19,16,12,10,8 ,6 ,5 ,4 ,4],
                     [330,263,209,166,132,105,83 ,66 ,53,42,33,27,21,17,14,11,9 ,7 ,6 ,5 ,4],
                     [360,286,228,181,144,114,91 ,72 ,58,46,36,29,23,19,15,12,10,8 ,6 ,5 ,4],
                     [390,310,247,196,156,124,98 ,78 ,62,50,39,31,25,20,16,13,10,8 ,7 ,5 ,4],
                     [420,334,266,211,168,133,106,84 ,67,53,42,34,27,22,17,14,11,9 ,7 ,6 ,5],
                     [450,358,284,226,180,143,114,90 ,72,57,45,36,29,23,18,15,12,9 ,8 ,6 ,5],
                     [480,382,303,241,192,152,121,96 ,77,61,48,39,31,25,20,16,13,10,8 ,7 ,5],
                     [510,406,322,256,204,162,129,102,81,65,51,41,33,26,21,17,13,11,9 ,7 ,6],
                     [540,429,341,271,215,171,136,108,86,68,54,43,35,28,22,18,14,11,9 ,7 ,6],
                     [570,453,360,286,227,181,144,114,91,72,57,46,36,29,23,19,15,12,10,8 ,6],
                     [600,477,379,301,239,190,151,120,96,76,60,48,38,31,24,19,16,12,10,8 ,7] ]
    
    @State private var pHSliderValue : Double = 7.5
    @State private var dkHSliderValue : Double = 5.0
    
    var dkHValue = 16
    var pHValue = 7.1
    var pHAddress : Int {
        return pHValues.firstIndex(of: pHSliderValue) ?? 0
    }
    
    var body: some View {
        Form {
            Section(header: Text(LocalizedStringKey("Select pH and dKH values")))
            {
                VStack {
                    HStack {
                        Text(LocalizedStringKey("pH value"))
                        Text("\(pHSliderValue, specifier :Constants.Specifier.one)")
                    }
                    HStack {
                        Image(systemName: "minus")
                        Slider(value:$pHSliderValue, in: 6.0...8.0, step: 0.1)
                        Image(systemName: "plus")
                    }
                }
                VStack {
                    HStack {
                        Text(LocalizedStringKey("dKH value"))
                        Text("\(dkHSliderValue, specifier :Constants.Specifier.zero)")
                    }
                    HStack {
                        Image(systemName: "minus")
                        Slider(value:$dkHSliderValue, in: 1...20, step: 1)
                        Image(systemName: "plus")
                    }
                }
            }
            Section(header: Text(LocalizedStringKey("Dissolved Carbon dioxide")))
            {
                HStack {
                    Text ("\(cO2Chart[(Int(dkHSliderValue)-1)][pHAddress])")
                    Text(LocalizedStringKey("parts per million (ppm)"))
                    
                }
            }
        }
        .navigationBarTitle(LocalizedStringKey("Carbon dioxide calculator"), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    pHSliderValue = 7.5
                                    dkHSliderValue = 5.0
                                    
                                }) {
                                    Image(systemName: "gobackward")
                                        .foregroundColor(.green)
                                }
        )
    }
}

struct CalculatorCO2View_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorCO2View()
    }
}
