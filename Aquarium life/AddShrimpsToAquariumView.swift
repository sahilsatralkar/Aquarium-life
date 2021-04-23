//
//  AddShrimpsToAquariumView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/01/21.
//

import SwiftUI

enum ShrimpsActiveAlert {
    case first, second, zero
}

struct AddShrimpsToAquariumView: View {
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
        return formatter
    }()
    
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest : FetchRequest<AddShrimp>
    var uuidFilter: String
    
    init(filter: String) {
        uuidFilter = filter
        fetchRequest = FetchRequest<AddShrimp>(entity: AddShrimp.entity(), sortDescriptors : [NSSortDescriptor(keyPath: \AddShrimp.date, ascending: false)], predicate: NSPredicate(format: "id BEGINSWITH %@", uuidFilter))
    }
    
    @State private var showingAddShrimp = false
    
    @State private var addShrimpNotificationAlert = false
    
    @State private var shrimpsActiveAlert: ShrimpsActiveAlert = .zero
    
    var body: some View {
        Form {
            Section (header:Text(LocalizedStringKey("ShrimpInAquarium")), footer: Text(LocalizedStringKey("TapToAddShrimpAndSwipe"))){
                List {
                    ForEach(fetchRequest.wrappedValue, id:\.self) { shrimp in
                        NavigationLink(destination: AquariumShrimpSelectedDetails(shrimpArrayIndex: Int(shrimp.shrimpArrayIndex))) {
                            VStack (alignment: .leading) {
                                Text("\(shrimp.shrimpName ?? "")")
                                    .font(.headline).padding(1)
                                
                                HStack {
                                    Image(systemName: "number.circle").frame(width:20)
                                    Text("\(shrimp.quantity , specifier: Constants.Specifier.zero)")
                                    Text(LocalizedStringKey("Nos"))
                                }.font(.footnote)
                                
                                HStack {
                                    Image(systemName: "calendar.circle").frame(width:20)
                                    Text("\(shrimp.date ?? Date(), formatter: Self.taskDateFormat)")
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

        .alert(isPresented: $addShrimpNotificationAlert) {
            switch shrimpsActiveAlert {
            
            case .first:
                return Alert(title : Text(LocalizedStringKey("UnlockShrimpsAlertTitle")), message: Text(LocalizedStringKey("UnlockShrimpsAlertMsg")), dismissButton: .default(Text(LocalizedStringKey("DismissButton"))))
            
            case .second :
            return Alert(title: Text("Shrimps limit reached!"), message: Text("Please delete shrimp rows to add new"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
            
            
            case .zero:
                return Alert(title : Text("Alert"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
            }
        }
        
        .navigationBarTitle(LocalizedStringKey("Shrimps"),displayMode: .inline)
        .navigationBarItems(trailing:HStack {
                                Button(action : {
                                    
                                    if UserDefaults.standard.bool(forKey: Constants.IAP.shrimpsPackProductID){
                                        self.showingAddShrimp = true
                                    }
                                    else {
                                        self.shrimpsActiveAlert = .first
                                        self.addShrimpNotificationAlert = true
                                        
                                        
                                    }
                                }) {
                                    Image(systemName: "plus")
                                }.accessibility(label: Text(LocalizedStringKey("AddShrimpAccess")))
            
        }
                            
        )
        .sheet(isPresented: $showingAddShrimp) {
            SelectShrimp(uuid: uuidFilter)
        }
        
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        
        for offset in offsets {
            
            let shrimp = self.fetchRequest.wrappedValue[offset]
            
            moc.delete(shrimp)
        }
        try? moc.save()
    }

}

struct AddShrimpsToAquariumView_Previews: PreviewProvider {
    static var previews: some View {
        AddShrimpsToAquariumView(filter: "")
    }
}
