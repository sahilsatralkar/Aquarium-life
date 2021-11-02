//
//  SelectCrab.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI

struct SelectCrab: View {
    @State private var crabSelected = 1
    @State private var crabQuantity = 1.0
    
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var presentationMode
    
    var uuidForAquarium : String
    
    init(uuid: String) {
        
        uuidForAquarium = uuid
    }
    
    
    let crabs : [Crab] = Bundle.main.decode(Constants.File.crabJSON)
    
    var body: some View {
        NavigationView {
            Form {
                Section (header:Text(LocalizedStringKey("SelectionOfCrab")))
                {
                    Picker(Constants.emptyString, selection: $crabSelected) {
                        ForEach(crabs, id: \.self.id) { crab in
                            Text("\(crab.name)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    HStack {
                        Text(LocalizedStringKey("Selection:"))
                        Text("\(crabs[crabSelected - 1].name)")
                    }
                    
                    HStack {
                        Text(LocalizedStringKey("Quantity:"))
                        Stepper(value: $crabQuantity, in: 1...99, step: 1) {
                            Text("\(crabQuantity, specifier: Constants.Specifier.zero)")
                            Text(LocalizedStringKey("Nos"))
                            
                        }
                        
                    }
                }
               
            }
            .navigationBarTitle(LocalizedStringKey("AddCrab"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action : {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text(LocalizedStringKey("DismissButton"))
                }
                ,trailing: Button(action : {
                    saveButton()
            }) {
                    Text(LocalizedStringKey("SaveButton"))
            }
            )
        }
        
    }
    func saveButton() {
        
        let aquariumCrab = AddCrab(context: self.moc)
        
        
        aquariumCrab.crabName = "\(self.crabs[crabSelected - 1].name)"
        aquariumCrab.quantity = self.crabQuantity
        aquariumCrab.crabArrayIndex = Int16(crabSelected - 1)
        aquariumCrab.date = Date()
        aquariumCrab.id = uuidForAquarium
        //self.aquariumFishNew.aquariumFishArray.append(aquariumFish)
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
}
struct SelectCrab_Previews: PreviewProvider {
    static var previews: some View {
        SelectCrab(uuid: "")
    }
}
