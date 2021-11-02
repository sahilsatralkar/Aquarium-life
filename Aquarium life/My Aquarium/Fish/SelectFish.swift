//
//  SelectFish.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/01/21.
//

import SwiftUI

struct SelectFish: View {
    
    @State private var fishSelected = 1
    @State private var fishQuantity = 1.0
    
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var presentationMode
    
    var uuidForAquarium : String
    
    init(uuid: String) {
        
        uuidForAquarium = uuid
    }
    
    
    let fishes : [Fish] = Bundle.main.decode(Constants.File.fishJSON)
    
    var body: some View {
        NavigationView {
            Form {
                Section (header:Text(LocalizedStringKey("SelectionOfFish")))
                {
                    Picker(Constants.emptyString, selection: $fishSelected) {
                        ForEach(fishes, id: \.self.id) { fish in
                            Text("\(fish.name)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    HStack {
                        Text(LocalizedStringKey("Selection:"))
                        Text("\(fishes[fishSelected - 1].name)")
                    }
                    
                    HStack {
                        Text(LocalizedStringKey("Quantity:"))
                        Stepper(value: $fishQuantity, in: 1...99, step: 1) {
                            Text("\(fishQuantity, specifier: Constants.Specifier.zero)")
                            Text(LocalizedStringKey("Nos"))
                            
                        }
                        
                    }
                }
               
            }
            .navigationBarTitle(LocalizedStringKey("AddFish"), displayMode: .inline)
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
        
        let aquariumFish = AddFish(context: self.moc)
        
        
        aquariumFish.fishName = "\(self.fishes[fishSelected - 1].name)"
        aquariumFish.quantity = self.fishQuantity
        aquariumFish.fishArrayIndex = Int16(fishSelected - 1)
        aquariumFish.date = Date()
        aquariumFish.id = uuidForAquarium
        //self.aquariumFishNew.aquariumFishArray.append(aquariumFish)
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
}
struct SelectFish_Previews: PreviewProvider {
    static var previews: some View {
        SelectFish(uuid: "")
    }
}
