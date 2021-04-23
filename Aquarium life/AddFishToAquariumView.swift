//
//  AddFishToAquariumView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/01/21.
//

import SwiftUI


struct AddFishToAquariumView: View {
    
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
            return formatter
        }()
        
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest : FetchRequest<AddFish>
    var uuidFilter: String
    
    init(filter: String) {
        uuidFilter = filter
        fetchRequest = FetchRequest<AddFish>(entity: AddFish.entity(), sortDescriptors : [NSSortDescriptor(keyPath: \AddFish.date, ascending: false)], predicate: NSPredicate(format: "id BEGINSWITH %@", uuidFilter))
    }
            
    @State private var showingAddFish = false
    
    @State private var maximumFishLimitAlert = false
    
    var body: some View {
        Form {
            Section (header:Text(LocalizedStringKey("FishInAquarium")), footer: Text(LocalizedStringKey("TapToAddFishAndSwipe"))) {
                List {
                    ForEach(fetchRequest.wrappedValue, id:\.self) { fish in
                        
                        NavigationLink(destination: AquariumFishSelectedDetails(fishArrayIndex: Int(fish.fishArrayIndex))) {
                        VStack (alignment: .leading) {
                            Text("\(fish.fishName ?? "")")
                                .font(.headline).padding(1)
                            HStack {
                                Image(systemName: "number.circle").frame(width:20)
                                Text("\(fish.quantity, specifier: Constants.Specifier.zero)")
                                Text(LocalizedStringKey("Nos"))
                            }
                            .font(.footnote)

                            HStack {
                                Image(systemName: "calendar.circle").frame(width:20)
                                Text("\(fish.date ?? Date(), formatter: Self.taskDateFormat)")
                            }.font(.footnote)
                            .padding(.top,1)
                            .padding(.bottom,1)
                                
                        }
                    }
                    
                    }
                    .onDelete(perform: delete)
                }
            }
            
            
        }
        .alert(isPresented: $maximumFishLimitAlert) {
            Alert(title: Text("Fish limit reached!"), message: Text("Please delete fish rows to add new"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
        }
        .navigationBarTitle(LocalizedStringKey("Fish"),displayMode: .inline)
        .navigationBarItems(trailing:
                                HStack {
                                Button(action : {
                                    self.showingAddFish = true
                                }) {
                                        Image(systemName: "plus")
                                    }.accessibility(label: Text(LocalizedStringKey("AddNewFishAccess")))
        }
        )
        
        .sheet(isPresented: $showingAddFish) {
            SelectFish(uuid: uuidFilter)
        }
        
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        for offset in offsets {
            
            let fish = self.fetchRequest.wrappedValue[offset]
            
            moc.delete(fish)
        }
        try? moc.save()
    }

}

struct AddFishToAquariumView_Previews: PreviewProvider {
    static var previews: some View {
        AddFishToAquariumView(filter: "")
    }
}
