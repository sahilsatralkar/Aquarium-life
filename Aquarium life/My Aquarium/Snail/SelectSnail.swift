//
//  SelectSnail.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI

struct SelectSnail: View {
    @State private var snailSelected = 1
    @State private var snailQuantity = 1.0
    
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var presentationMode
    
    var uuidForAquarium : String
    
    init(uuid: String) {
        
        uuidForAquarium = uuid
    }
    
    
    let snails : [Snail] = Bundle.main.decode(Constants.File.snailJSON)
    
    var body: some View {
        NavigationView {
            Form {
                Section (header:Text(LocalizedStringKey("SelectionOfSnail")))
                {
                    Picker(Constants.emptyString, selection: $snailSelected) {
                        ForEach(snails, id: \.self.id) { snail in
                            Text("\(snail.name)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    HStack {
                        Text(LocalizedStringKey("Selection:"))
                        Text("\(snails[snailSelected - 1].name)")
                    }
                    
                    HStack {
                        Text(LocalizedStringKey("Quantity:"))
                        Stepper(value: $snailQuantity, in: 1...99, step: 1) {
                            Text("\(snailQuantity, specifier: Constants.Specifier.zero)")
                            Text(LocalizedStringKey("Nos"))
                            
                        }
                        
                    }
                }
               
            }
            .navigationBarTitle(LocalizedStringKey("AddSnail"), displayMode: .inline)
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
        
        let aquariumSnail = AddSnail(context: self.moc)
        
        
        aquariumSnail.snailName = "\(self.snails[snailSelected - 1].name)"
        aquariumSnail.quantity = self.snailQuantity
        aquariumSnail.snailArrayIndex = Int16(snailSelected - 1)
        aquariumSnail.date = Date()
        aquariumSnail.id = uuidForAquarium
        //self.aquariumFishNew.aquariumFishArray.append(aquariumFish)
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
}
struct SelectSnail_Previews: PreviewProvider {
    static var previews: some View {
        SelectSnail(uuid: "")
    }
}
