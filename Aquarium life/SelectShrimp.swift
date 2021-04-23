//
//  SelectShrimp.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/01/21.
//

import SwiftUI

struct SelectShrimp: View {
    
    @State private var shrimpSelected = 0
    @State private var shrimpQuantity = 1.0
    
    @Environment(\.presentationMode) var presentationMode
    
    var uuidForAquarium : String
    
    init(uuid: String) {
        
        uuidForAquarium = uuid
    }
    
    @Environment(\.managedObjectContext) var moc
    
    let shrimps : [Shrimp] = Bundle.main.decode(Constants.File.shrimpJSON)
    
    var body: some View {
        NavigationView {
        Form {
            Section (header:Text(LocalizedStringKey("SelectionOfShrimp")))
            {
                Picker(Constants.emptyString, selection: $shrimpSelected) {

                    ForEach(0..<shrimps.count) { i in
                        Text("\(shrimps[i].name)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                HStack {
                    Text(LocalizedStringKey("Selection:"))
                    Text ("\(shrimps[shrimpSelected].name)")
                }
                
                HStack {
                    Text(LocalizedStringKey("Quantity:"))
                    Stepper(value: $shrimpQuantity, in: 1...99, step: 1) {
                        Text("\(shrimpQuantity, specifier: Constants.Specifier.zero)")
                        Text(LocalizedStringKey("Nos"))
                    }
                    
                }
            }
            
        }
        .navigationBarTitle(LocalizedStringKey("AddShrimp"), displayMode: .inline)
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
        
        let aquariumShrimps = AddShrimp(context: self.moc)
        
        aquariumShrimps.shrimpName = "\(self.shrimps[shrimpSelected].name)"
        aquariumShrimps.quantity = self.shrimpQuantity
        aquariumShrimps.shrimpArrayIndex = Int16(self.shrimpSelected)
        aquariumShrimps.date = Date()
        aquariumShrimps.id = self.uuidForAquarium
        
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
}

struct SelectShrimp_Previews: PreviewProvider {
    static var previews: some View {
        SelectShrimp( uuid: "")
    }
}
