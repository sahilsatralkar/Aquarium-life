//
//  MyTankView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import SwiftUI

struct MyTankView: View {
    
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
            return formatter
        }()
    
    @FetchRequest(entity: AddAquarium.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AddAquarium.date, ascending: false)]) var addAquariumResults: FetchedResults<AddAquarium>

    @Environment(\.managedObjectContext) var moc
    
    @State private var showingAddAquarium = false
    
    @State private var maxAquariumsLimitAlert = false
    
    @State var addTankToggle = false
    
    let units = ["cm","inches"]
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        NavigationView {
            Form{
                    Section (header: Text("TapOnPlus")) {
                    List {
                        ForEach(addAquariumResults , id: \.id) { aquarium in
                            
                                NavigationLink(destination: AquariumDetailsView(selectedAquarium: aquarium)) {
                                VStack(alignment: .leading) {
                                    Text("\(aquarium.aquariumName ?? "")")
                                        .font(.title2)
                                    
                                    VStack(alignment: .leading){
                                        Group {
                                            HStack {
                                                Image(systemName: "drop")
                                                    .frame(width:20)
                                                    .foregroundColor(.blue)
                                                    Text("\(aquarium.volume, specifier: Constants.Specifier.zero)")
                                                    Text(LocalizedStringKey("LitersVolume")).padding(.leading, -5)
                                                
                                            }
                                            HStack {
                                                Image(systemName: "square.stack.3d.up")
                                                    .frame(width:20)
                                                    .foregroundColor(.gray)
                                                    Text(LocalizedStringKey(aquarium.externalFiltration ?? ""))
                                                    Text(LocalizedStringKey("Filtration")).padding(.leading, -5)
                                                
                                            }
                                           .padding(.top,1)
//                                            .padding(.bottom,1)
                                            HStack {
                                                Image(systemName: "circle.grid.3x3.fill")
                                                    .frame(width:20)
                                                    .foregroundColor(.black)
                                                    Text(LocalizedStringKey(aquarium.substrate ?? ""))
                                                    Text(LocalizedStringKey("Substrate")).padding(.leading, -5)
                                            }
                                        }
                                        .padding(.top,1)
                                        HStack {
                                            Image(systemName: "thermometer")
                                                .frame(width:20)
                                                .foregroundColor(.red)
                                            if aquarium.heater == "Yes" {
                                                Text(LocalizedStringKey("WithHeating"))
                                            } else {
                                                Text(LocalizedStringKey("WithoutHeating"))
                                            }
                                        }
                                        .padding(.top,1)
                                        HStack {
                                            Image(systemName: "calendar")
                                                .frame(width:20)
                                                .foregroundColor(.green)
                                            Text("Since \(aquarium.date ?? Date(), formatter: Self.taskDateFormat)")
                                        }
                                        .padding(.top,1)
                                        .padding(.bottom,1)
                                    }
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .padding(1)
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
           }
            .navigationBarItems(trailing: HStack {
                Button(action :
                        {
                            self.showingAddAquarium = true
                            
                        })
                {
                    Image(systemName: "plus")
                        .accessibility(label: Text(LocalizedStringKey("AddNewAquarium")))
                }
            }
            )
            .navigationBarTitle(Text(LocalizedStringKey("MyAquariums")))
            .sheet(isPresented: $showingAddAquarium) {
                AddAquariumView()
            }
        }
        //Fixed bug where row was remaining selected. v1.4.1- Start
        .navigationViewStyle(StackNavigationViewStyle())
        //v1.4.1- End
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {

        for offset in offsets {
            
            let aquarium = addAquariumResults[offset]
            
            moc.delete(aquarium)
        }
        try? moc.save()
    }
}

struct MyTankView_Previews: PreviewProvider {
    static var previews: some View {
        MyTankView()
    }
}
