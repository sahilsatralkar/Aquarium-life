//
//  NotesView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/02/21.
//

import SwiftUI

struct NotesView: View {
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
    
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest = FetchRequest<Notes>(entity: Notes.entity(), sortDescriptors : [NSSortDescriptor(keyPath: \Notes.date, ascending: false)])
    
    @State private var showingAddNotes = false
    
    var body: some View {
        NavigationView {
            Form {
                Section (footer: Text(LocalizedStringKey("Tap on + to add new Notes"))) {
                    List {
                        ForEach(fetchRequest.wrappedValue, id:\.self) { note in
                            
                            NavigationLink(destination: NoteDetailsView(aquariumNote: note)) {
                                
                                VStack(alignment: .leading) {
                                    Text("\(note.label ?? "")").font(.headline).padding(1)
                                    
                                    HStack {
                                        Image(systemName: "calendar.circle").frame(width:20)
                                        Text("\(note.date ?? Date(), formatter: Self.taskDateFormat)")
                                    }.font(.footnote)//.foregroundColor(.gray)
                                    HStack {
                                        Image(systemName: "clock").frame(width:20)
                                        Text("\(note.date ?? Date(), formatter: Self.taskTimeFormat)")
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
            .navigationBarTitle(Text(LocalizedStringKey("MyNotes")))
            .navigationBarItems(trailing: HStack {
                //EditButton()
                Button(action : {
                    self.showingAddNotes = true
                    
                }) {
                    Image(systemName: "plus")
                }.accessibility(label: Text(LocalizedStringKey("Add new Notes to My Notes")))
            }
            )
            .sheet(isPresented: $showingAddNotes) {
                AddNotes()
            }
        }
        .onAppear(perform:{
            
            
            if UserDefaults.standard.bool(forKey: Constants.NTSNote){
                //
            } else {
            
                let newNote = Notes(context: moc)
                
                newNote.label = "New Tank Syndrome"
                newNote.content = "The number one reason for fish deaths among beginner aquarists is the absence of nitrifying bacteria inside their aquarium. Fish introduce Ammonia into the water through their waste and leftover food. Ammonia is toxic and it leads to death of fish in new aquariums.\nThe nitrifying bacteria if present, converts Ammonia into Nitrites and further Nitrites into Nitrates. Nitrates are not as toxic as Ammonia and fish can survive in moderate levels of Nitrates.\nThe nitrifying bacteria are formed automatically in the aquarium water and they form colonies on all surfaces in the aquarium and its filter. The key thing to remember is that it takes at least 3-4 weeks for nitrifying bacteria to form in sufficient quantity to support the fish load. This process can be kickstarted by initially running an old filter, which would contain nitrifying bacteria, on a new aquarium for a week. This will speed up the nitrogen cycle and fish can be safely introduced incrementally in the aquarium."
                    
                newNote.date = Date()
                newNote.id = UUID()
                
                try? self.moc.save()
                
                UserDefaults.standard.set(true, forKey: Constants.NTSNote)
                
            }
        })
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        for offset in offsets {
            
            let note = self.fetchRequest.wrappedValue[offset]
            
            moc.delete(note)
        }
        try? moc.save()
    }
}
    struct NotesView_Previews: PreviewProvider {
        static var previews: some View {
            NotesView()
        }
    }
