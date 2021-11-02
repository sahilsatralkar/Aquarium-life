//
//  SelectPlant.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/01/21.
//

import SwiftUI

struct SelectPlant: View {
    
    @State private var plantSelected = 0
    @State private var plantQuantity = 1.0
    
    @Environment(\.presentationMode) var presentationMode
    
    var uuidForAquarium : String
    
    init(uuid: String) {
        
        uuidForAquarium = uuid
    }
    
    @Environment(\.managedObjectContext) var moc
    
    let plants : [Plant] = Bundle.main.decode(Constants.File.plantJSON)
    
    var body: some View {
        NavigationView {
            Form {
                Section (header:Text(LocalizedStringKey("SelectionOfPlant")))
                {
                    Picker(Constants.emptyString, selection: $plantSelected) {
                        
                        ForEach(0..<plants.count) { i in
                            Text("\(plants[i].name)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    HStack {
                        Text(LocalizedStringKey("Selection:"))
                        Text ("\(plants[plantSelected].name)")
                    }
                    
                    HStack {
                        Text(LocalizedStringKey("Quantity:"))
                        Stepper(value: $plantQuantity, in: 1...99, step: 1) {
                            Text("\(plantQuantity, specifier: Constants.Specifier.zero)")
                            Text(LocalizedStringKey("Nos"))
                        }
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("AddPlant"), displayMode: .inline)
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
        
        let aquariumPlants = AddPlant(context: self.moc)
        
        aquariumPlants.plantName = "\(self.plants[plantSelected].name)"
        aquariumPlants.quantity = self.plantQuantity
        aquariumPlants.plantArrayIndex = Int16(self.plantSelected)
        aquariumPlants.date = Date()
        aquariumPlants.id = self.uuidForAquarium
        
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
}

struct SelectPlant_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlant(uuid: "")
    }
}
