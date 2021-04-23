//
//  NoteDetailsView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 11/02/21.
//

import SwiftUI

struct NoteDetailsView: View {
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        return formatter
    }()
    
    static let taskTimeFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
            return formatter
        }()
    
    var aquariumNote : Notes
    
    var body: some View {
        ScrollView(.vertical) {
            
            VStack(alignment: .leading) {
                Text("\(aquariumNote.label ?? "")")
                    .font(.title)
                    .padding()
                    .padding(.top,8)
                
                Divider()
                
                Group {
                    HStack {
                        Text("Date: ").font(.headline)
                        Text("\(aquariumNote.date ?? Date(), formatter: Self.taskDateFormat)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Time: ").font(.headline)
                        Text("\(aquariumNote.date ?? Date(), formatter: Self.taskTimeFormat)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("Text: ").font(.headline)

                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 2)
                    .padding(.top, 2)
                    HStack {
                        Text("\(aquariumNote.content ?? "")")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 5)
                    .padding(.top, 5)
                }
            }
        }
        .navigationBarTitle("Note details", displayMode: .inline)
    }
}

struct NoteDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailsView(aquariumNote: Notes())
    }
}
