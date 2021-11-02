//
//  AddLogView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 15/01/21.
//

import SwiftUI
import WidgetKit

struct AddLogView: View {
    
    var uuidForAquarium : String
    
    init(uuid: String) {
        
        uuidForAquarium = uuid
    }
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var temperatureSliderValue : Double = 20
    @State private var pHSliderValue : Double = 7.5
    @State private var ammoniaSliderValue : Double = 0
    @State private var nitriteSliderValue : Double = 0
    @State private var nitrateSliderValue : Double = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var computedTemperature : Double {
        let tempTankVolumeLength = temperatureSliderValue
        return ((tempTankVolumeLength * (9.0/5.0)) + 32)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        HStack {
                            Text(LocalizedStringKey("Temperature="))
                            Text("\(temperatureSliderValue, specifier :Constants.Specifier.zero)°C / \(computedTemperature, specifier:Constants.Specifier.zero)°F")
                                
                        }.padding(.top)
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$temperatureSliderValue, in: 0...50, step: 1.0)
                            Image(systemName: "plus")
                        }
                    }
                }
                
                Section {
                    VStack {
                        HStack {
                            Text(LocalizedStringKey("pH="))
                            Text("\(pHSliderValue, specifier :Constants.Specifier.one) ")
                                
                        }.padding(.top)
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$pHSliderValue, in: 6.0...8.0, step: 0.1)
                            Image(systemName: "plus")
                        }
                    }
                }
                Section {
                    VStack {
                        HStack {
                            Text(LocalizedStringKey("Ammonia="))
                            Text("\(ammoniaSliderValue, specifier :Constants.Specifier.two)")
                            Text(LocalizedStringKey("ppm"))
                                
                        }.padding(.top)
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$ammoniaSliderValue, in: 0...5.0, step: 0.25)
                            Image(systemName: "plus")
                        }
                    }
                }
                Section {
                    VStack {
                        HStack {
                            Text(LocalizedStringKey("Nitrite="))
                            Text("\(nitriteSliderValue, specifier :Constants.Specifier.one)")
                            Text(LocalizedStringKey("ppm"))
                                
                        }.padding(.top)
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$nitriteSliderValue, in: 0...5.0, step: 0.25)
                            Image(systemName: "plus")
                        }
                    }
                }
                Section {
                    VStack {
                        HStack {
                            Text(LocalizedStringKey("Nitrate="))
                            Text("\(nitrateSliderValue, specifier :Constants.Specifier.zero)")
                            Text(LocalizedStringKey("ppm"))
                                
                        }.padding(.top)
                        
                        HStack {
                            Image(systemName: "minus")
                            Slider(value:$nitrateSliderValue, in: 0...100, step: 5.0)
                            Image(systemName: "plus")
                        }
                    }
                }
                
            }
            .navigationBarTitle(LocalizedStringKey("AddNewLog"),displayMode: .inline)
            .navigationBarItems(leading: Button(action : {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text(LocalizedStringKey("DismissButton"))
            },
            trailing: Button(action : {
                saveButton()
            }) {
                Text(LocalizedStringKey("SaveButton"))
            }
            )
        }
        
    }
    func saveButton() {
        
        let aquariumLog = AddLog(context: self.moc)
        
        aquariumLog.temp = self.temperatureSliderValue
        aquariumLog.pH = self.pHSliderValue
        aquariumLog.ammonia = self.ammoniaSliderValue
        aquariumLog.nitrites = self.nitriteSliderValue
        aquariumLog.nitrates = self.nitrateSliderValue
        aquariumLog.date = Date()
        aquariumLog.id = self.uuidForAquarium
        
        try? self.moc.save()
        
        //v1.5 reload widget
        WidgetCenter.shared.reloadAllTimelines()

        
        self.presentationMode.wrappedValue.dismiss()
        
    }
}

struct AddLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddLogView(uuid: "")
    }
}
