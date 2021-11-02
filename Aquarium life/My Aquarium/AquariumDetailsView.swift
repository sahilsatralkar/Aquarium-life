//
//  AquariumDetailsView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 08/01/21.
//

import SwiftUI

struct AquariumDetailsView: View {
    
    @State private var showingActionSheetAlert = false
    
    let liveStockCategories = ["Fish","Shrimps","Plants","Snails","Crabs"]
    
    var selectedAquarium : AddAquarium
    
    var body: some View {
        Form {
            
            Section(header: Text(LocalizedStringKey("AquariumLife"))) {
                List {
                    
                    NavigationLink(
                        destination: AddFishToAquariumView(filter: selectedAquarium.id ?? UUID().uuidString)) {
                        //destination : AdditionalInfoView()){
                        Text(LocalizedStringKey(liveStockCategories[0])).font(.headline)
                        
                    }
                    NavigationLink(
                        destination: AddShrimpsToAquariumView(filter: selectedAquarium.id ?? UUID().uuidString)){
                        Text(LocalizedStringKey(liveStockCategories[1])).font(.headline)
                    }
                    
                    NavigationLink(
                        destination: AddPlantsToAquariumView(filter: selectedAquarium.id ?? UUID().uuidString)){
                        Text(LocalizedStringKey(liveStockCategories[2])).font(.headline)
                        
                    }
                    //Added v1.6- Start
                    NavigationLink(
                        destination: AddSnailsToAquariumView(filter: selectedAquarium.id ?? UUID().uuidString)){
                        Text(LocalizedStringKey(liveStockCategories[3])).font(.headline)
                        
                    }
                    NavigationLink(
                        destination: AddCrabsToAquariumView(filter: selectedAquarium.id ?? UUID().uuidString)){
                        Text(LocalizedStringKey(liveStockCategories[4])).font(.headline)
                        
                    }
                    //Added v1.6- End
                }
            }
            Section(header: Text(LocalizedStringKey("LogBook")), footer: Text(LocalizedStringKey("TapToSeeDetails"))) {
                List {
                    NavigationLink(
                        destination: LogBookDetailsView(filter: selectedAquarium.id ?? UUID().uuidString)){
                        Text(LocalizedStringKey("LogRecords")).font(.headline)
                    }
                }
                
            }
            
        }
        .navigationBarTitle("\(selectedAquarium.aquariumName ?? "")", displayMode: .inline)
    }
}

struct AquariumDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AquariumDetailsView(selectedAquarium: AddAquarium())
    }
}
