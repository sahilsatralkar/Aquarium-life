//
//  LogBookDetailsView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 15/01/21.
//

import SwiftUI

struct LogBookDetailsView: View {
    
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
            return formatter
        }()
    static let taskTimeFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
            return formatter
        }()
    
    static let dayFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
            return formatter
        }()
    
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest : FetchRequest<AddLog>
    var uuidFilter: String
    
    init(filter: String) {
        uuidFilter = filter
        fetchRequest = FetchRequest<AddLog>(entity: AddLog.entity(), sortDescriptors : [NSSortDescriptor(keyPath: \AddLog.date, ascending: false)], predicate: NSPredicate(format: "id BEGINSWITH %@", uuidFilter))
    }
    
    @State private var showingAddLog = false
    
    @State private var maximumLogLimitAlert = false
    
    var body: some View {
        Form {
            Section (header:Text(LocalizedStringKey("LogRecords")), footer: Text(LocalizedStringKey("TapToAddLogsAndSwipe"))){
            List {
                ForEach(fetchRequest.wrappedValue, id:\.self) { log in
                    NavigationLink(destination: LogBookDetailsSelectionView(aquariumLog: log)) {
                        VStack(alignment: .leading) {
                            
                            Text("\(log.date ?? Date(), formatter: Self.taskDateFormat)")
                                .font(.headline).padding(1)
                            HStack {
                                Image(systemName: "calendar.circle").frame(width:20)
                                Text("\(log.date ?? Date(), formatter: Self.dayFormat)")
                            }.font(.footnote)
                            
                            
                            HStack {
                                Image(systemName: "clock").frame(width:20)
                                Text("\(log.date ?? Date(), formatter: Self.taskTimeFormat)")
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
        .alert(isPresented: $maximumLogLimitAlert) {
            Alert(title: Text("Logs limit reached!"), message: Text("Please delete log records to add new"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
        }
        .navigationBarItems(trailing:HStack{
                                //EditButton()
                                Button(action : {
                                    self.showingAddLog = true
                                        
                                    }) {
                                        Image(systemName: "plus")
                                    }.accessibility(label: Text(LocalizedStringKey("AddLogAccess")))
        }
        )
        .navigationBarTitle(Text(LocalizedStringKey("LogBook")))
        .sheet(isPresented: $showingAddLog) {
            AddLogView(uuid: uuidFilter)
        }
    }
    
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        for offset in offsets {
            
            let log = self.fetchRequest.wrappedValue[offset]
            
            moc.delete(log)
        }
        try? moc.save()
        
        
    }
}
struct LogBookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LogBookDetailsView(filter: "")
    }
}
