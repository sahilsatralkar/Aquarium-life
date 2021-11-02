//
//  AddPlantsToAquariumView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/01/21.
//

import SwiftUI

enum PlantsActiveAlert {
    case first, second, zero
}

struct AddPlantsToAquariumView: View {
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
        return formatter
    }()
    
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest : FetchRequest<AddPlant>
    var uuidFilter: String
    
    init(filter: String) {
        uuidFilter = filter
        fetchRequest = FetchRequest<AddPlant>(entity: AddPlant.entity(), sortDescriptors : [NSSortDescriptor(keyPath: \AddPlant.date, ascending: false)], predicate: NSPredicate(format: "id BEGINSWITH %@", uuidFilter))
    }
    
    @State private var showingAddPlant = false
    
    @State private var addPlantNotificationAlert = false
    
    @State private var plantsActiveAlert: PlantsActiveAlert = .zero
    
    var body: some View {
        Form {
            Section (header:Text(LocalizedStringKey("PlantsInAquarium")), footer: Text(LocalizedStringKey("TapToAddPlantsAndSwipe"))){
                List {
                    ForEach(fetchRequest.wrappedValue, id:\.self) { plant in
                        
                        NavigationLink(destination: AquariumPlantSelectedDetails(plantArrayIndex: Int(plant.plantArrayIndex))) {
                            
                            VStack(alignment: .leading) {
                                Text("\(plant.plantName ?? "")").font(.headline).padding(1)
                                HStack {
                                    Image(systemName: "number.circle").frame(width:20)
                                    Text("\(plant.quantity, specifier: Constants.Specifier.zero) nos")
                                }.font(.footnote)
                                
                                HStack {
                                    Image(systemName: "calendar.circle").frame(width:20)
                                    Text("\(plant.date ?? Date(), formatter: Self.taskDateFormat)")
                                }.font(.footnote)//.foregroundColor(.gray)
                                .padding(.top,1)
                                .padding(.bottom,1)
                                
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        
        .alert(isPresented: $addPlantNotificationAlert) {
            switch plantsActiveAlert {
            
            case .first:
                return Alert(title : Text(LocalizedStringKey("UnlockPlantsAlertTitle")), message: Text(LocalizedStringKey("UnlockPlantsAlertMsg")), dismissButton: .default(Text(LocalizedStringKey("DismissButton"))))
                
            case .second :
                return Alert(title: Text("Plants limit reached!"), message: Text("Please delete plant rows to add new"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                
            case .zero:
                return Alert(title : Text("Alert"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
            }
        }
        .navigationBarTitle(LocalizedStringKey("Plants"),displayMode: .inline)
        .navigationBarItems(trailing: HStack {
            Button(action : {
                
                if UserDefaults.standard.bool(forKey: Constants.IAP.plantsPackProductID){
                    self.showingAddPlant = true
                    
                }
                else {
                    
                    self.plantsActiveAlert = .first
                    self.addPlantNotificationAlert = true
                    
                }
                
            }) {
                Image(systemName: "plus")
            }.accessibility(label: Text(LocalizedStringKey("AddPlantAccess")))
        }
        )
        .sheet(isPresented: $showingAddPlant) {
            SelectPlant(uuid: uuidFilter)
        }
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        for offset in offsets {
            
            let plant = self.fetchRequest.wrappedValue[offset]
            
            moc.delete(plant)
        }
        try? moc.save()
    }

}

struct AddPlantsToAquariumView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantsToAquariumView(filter: "")
    }
}
