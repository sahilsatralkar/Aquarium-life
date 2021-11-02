//
//  AddSnailsToAquariumView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 01/11/21.
//

import SwiftUI


struct AddSnailsToAquariumView: View {
    
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
            return formatter
        }()
        
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest : FetchRequest<AddSnail>
    var uuidFilter: String

    init(filter: String) {
        uuidFilter = filter
        fetchRequest = FetchRequest<AddSnail>(entity: AddSnail.entity(), sortDescriptors : [NSSortDescriptor(keyPath: \AddSnail.date, ascending: false)], predicate: NSPredicate(format: "id BEGINSWITH %@", uuidFilter))
    }
            
    @State private var showingAddSnail = false
        
    var body: some View {
        Form {
            Section (header:Text(LocalizedStringKey("SnailInAquarium")), footer: Text(LocalizedStringKey("TapToAddSnailAndSwipe"))) {
                List {
                    ForEach(fetchRequest.wrappedValue, id:\.self) { snail in
                        
                        NavigationLink(destination: AquariumSnailSelectedDetails(snailArrayIndex: Int(snail.snailArrayIndex))) {
                        VStack (alignment: .leading) {
                            Text("\(snail.snailName ?? "")")
                                .font(.headline).padding(1)
                            HStack {
                                Image(systemName: "number.circle").frame(width:20)
                                Text("\(snail.quantity, specifier: Constants.Specifier.zero)")
                                Text(LocalizedStringKey("Nos"))
                            }
                            .font(.footnote)

                            HStack {
                                Image(systemName: "calendar.circle").frame(width:20)
                                Text("\(snail.date ?? Date(), formatter: Self.taskDateFormat)")
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
        .navigationBarTitle(LocalizedStringKey("Snails"),displayMode: .inline)
        .navigationBarItems(trailing:
                                HStack {
                                Button(action : {
                                    self.showingAddSnail = true
                                }) {
                                        Image(systemName: "plus")
                                    }.accessibility(label: Text(LocalizedStringKey("AddNewSnailAccess")))
        }
        )
        
        .sheet(isPresented: $showingAddSnail) {
            SelectSnail(uuid: uuidFilter)
        }
        
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        for offset in offsets {
            
            let snail = self.fetchRequest.wrappedValue[offset]
            
            moc.delete(snail)
        }
        try? moc.save()
    }

}

struct AddSnailsToAquariumView_Previews: PreviewProvider {
    static var previews: some View {
        AddSnailsToAquariumView(filter: "")
    }
}
