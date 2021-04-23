//
//  LiveStockView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import SwiftUI

struct LiveStockView: View {
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State private var liveStockSelected = 0
    
    let liveStockCategories : [String] = ["Fish","Shrimps","Plants"]
    
    private var liveStockSelectedMenu : Int {
        return liveStockSelected
    }
    let fishes : [Fish] = Bundle.main.decode(Constants.File.fishJSON)
    
    
//    let sortedFishes = fishes.sorted {
//        $0.name < $1.name
//    }
//
    let shrimps : [Shrimp] = Bundle.main.decode(Constants.File.shrimpJSON)
    let plants : [Plant] = Bundle.main.decode(Constants.File.plantJSON)
    
    var body: some View {
        NavigationView {
            Form{
                Section 
                {
                    Picker(LocalizedStringKey("PresentSelection"), selection: $liveStockSelected) {
                        ForEach(0 ..< liveStockCategories.count) {
                            Text(LocalizedStringKey(self.liveStockCategories[$0]))
                        }
                    }
                }
                .font(.headline)
                .pickerStyle(DefaultPickerStyle())
                Section (header:Text(LocalizedStringKey("LISTOF\(self.liveStockCategories[liveStockSelected])"))){
                    List {
                        if liveStockSelectedMenu == 0 {
                            ForEach(self.fishes.filter {
                                searchBar.text.isEmpty ? true : $0.name.localizedStandardContains(searchBar.text)
                                
                           // }, id: \.self.id)
                                //update 1.4
                            })
                            { fish in
                                NavigationLink(
                                    destination: LiveStockFishDetailView(fish: fish)){
                                    
                                    Image(systemName: "doc.circle")
                                        .foregroundColor(.green)
                                    Text(fish.name)
                                }
                            }
                        }
                        if liveStockSelectedMenu == 1 {
                            ForEach(self.shrimps.filter {
                                searchBar.text.isEmpty ? true : $0.name.localizedStandardContains(searchBar.text)
                                
                            }, id: \.self.id)
                            { shrimp in
                                NavigationLink(
                                    destination: LiveStockShrimpDetailView(shrimp: shrimp)){
                                    
                                    Image(systemName: "doc.circle")
                                        .foregroundColor(.green)
                                    Text(shrimp.name)
                                    
                                }
                            }
                            
                        }
                        if liveStockSelectedMenu == 2 {
                            ForEach(self.plants.filter {
                                searchBar.text.isEmpty ? true : $0.name.localizedStandardContains(searchBar.text)
                                
                            }, id: \.self.id)
                            { plant in
                                NavigationLink(
                                    destination: LiveStockPlantDetailView(plant: plant)){
                                    
                                    Image(systemName: "doc.circle")
                                        .foregroundColor(.green)
                                    Text(plant.name)
                                    
                                }
                            }
                            
                        }
                    }
                }
            }
            
            .navigationBarTitle(Text(LocalizedStringKey("CareSheets")))
            .add(self.searchBar)
        }
    }
}

struct LiveStockView_Previews: PreviewProvider {
    static var previews: some View {
        LiveStockView()
    }
}
