//
//  AddCrabsToAquarium.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI

struct AddCrabsToAquariumView: View {
    
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
            return formatter
        }()
        
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest : FetchRequest<AddCrab>
    var uuidFilter: String

    init(filter: String) {
        uuidFilter = filter
        fetchRequest = FetchRequest<AddCrab>(entity: AddCrab.entity(), sortDescriptors : [NSSortDescriptor(keyPath: \AddCrab.date, ascending: false)], predicate: NSPredicate(format: "id BEGINSWITH %@", uuidFilter))
    }
            
    @State private var showingAddCrab = false
        
    var body: some View {
        Form {
            Section (header:Text(LocalizedStringKey("CrabInAquarium")), footer: Text(LocalizedStringKey("TapToAddCrabAndSwipe"))) {
                List {
                    ForEach(fetchRequest.wrappedValue, id:\.self) { crab in
                        
                        NavigationLink(destination: AquariumCrabSelectedDetails(crabArrayIndex: Int(crab.crabArrayIndex))) {
                        VStack (alignment: .leading) {
                            Text("\(crab.crabName ?? "")")
                                .font(.headline).padding(1)
                            HStack {
                                Image(systemName: "number.circle").frame(width:20)
                                Text("\(crab.quantity, specifier: Constants.Specifier.zero)")
                                Text(LocalizedStringKey("Nos"))
                            }
                            .font(.footnote)

                            HStack {
                                Image(systemName: "calendar.circle").frame(width:20)
                                Text("\(crab.date ?? Date(), formatter: Self.taskDateFormat)")
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
        .navigationBarTitle(LocalizedStringKey("Crabs"),displayMode: .inline)
        .navigationBarItems(trailing:
                                HStack {
                                Button(action : {
                                    self.showingAddCrab = true
                                }) {
                                        Image(systemName: "plus")
                                    }.accessibility(label: Text(LocalizedStringKey("AddNewCrabAccess")))
        }
        )
        
        .sheet(isPresented: $showingAddCrab) {
            SelectCrab(uuid: uuidFilter)
        }
        
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        for offset in offsets {
            
            let crab = self.fetchRequest.wrappedValue[offset]
            
            moc.delete(crab)
        }
        try? moc.save()
    }

}

struct AddCrabsToAquariumView_Previews: PreviewProvider {
    static var previews: some View {
        AddCrabsToAquariumView(filter: "")
    }
}
