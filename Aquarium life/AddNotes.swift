//
//  AddNotes.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/02/21.
//

import SwiftUI
import Combine

enum NotesAlert {
    case first, second, zero
}

struct AddNotes: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var textFieldCharsManagerAddNote = TextFieldCharsManager()
    
    @State private var noteContent: String = ""
    
    @State private var showAlert = false
    @State private var notesAlert: NotesAlert = .zero
    
    @State private var keyboardHeight: CGFloat = 0
    
    
    var body: some View {
        NavigationView {
            
            Form{
                Section(header: Text(LocalizedStringKey("Label"))) {
                    TextField(LocalizedStringKey("eg Angelfish"), text: $textFieldCharsManagerAddNote.userName )
                    
                }
                .padding(.top, 2)
                
                Section(header: Text(LocalizedStringKey("Text"))) {
                    
                    TextEditor(text: $noteContent)
                        .foregroundColor(Color.gray).frame(minHeight: 150)
                }
            }
            
            .alert(isPresented: $showAlert){
                switch notesAlert {
                case .first:
                    return Alert(title : Text(LocalizedStringKey("LabelEmptyTitle")), message: Text(LocalizedStringKey("LabelEmptyMsg")), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                    
                case .zero:
                    return Alert(title : Text("Alert"), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                    
                    
                case .second:
                    return Alert(title : Text(LocalizedStringKey("NoteEmptyTitle")), message: Text(LocalizedStringKey("NoteEmptyMsg")), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
                    
                }
            }
            
            .navigationBarTitle(LocalizedStringKey("Add Notes"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text(LocalizedStringKey("DismissButton"))
            } ,trailing: Button(action : {
                saveButton()
            }) {
                Text(LocalizedStringKey("SaveButton"))
            }
            )
            
        }
    }
    
    func saveButton(){
        if textFieldCharsManagerAddNote.userName == Constants.emptyString {
            self.notesAlert = .first
            self.showAlert = true
        }
        else if self.noteContent == Constants.emptyString {
            self.notesAlert = .second
            self.showAlert = true
        }
        else {
            let newNote = Notes(context: moc)
            
            newNote.label = self.textFieldCharsManagerAddNote.userName
            newNote.content = self.noteContent
            newNote.date = Date()
            newNote.id = UUID()
            
            try? self.moc.save()
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddNotes_Previews: PreviewProvider {
    static var previews: some View {
        AddNotes()
    }
}
