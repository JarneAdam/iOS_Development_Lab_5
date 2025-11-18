//
//  AddModifyEventView.swift
//  Lab_5
//
//  Created by Jarne Adam on 05/11/2025.
//

import SwiftUI

struct AddModifyEventView: View {
    let isNew: Bool
    @State var event : EventModel
    @Environment(UurroosterDataStore.self) private var uurroosterDataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack() {
            Section(isNew ? "ADD EVENT": "EDIT EVENT") {
                Form {
                    isNew ? Text("Title?") : nil
                    TextEditor(text: $event.title).lineSpacing(3)
                    TextField("Location?", text: $event.location)
                    Toggle(isOn: $event.allDay) {
                        Text("All day?")
                    }.tint(Color.accentColor)
                    if event.allDay {
                        DatePicker("Date?", selection: $event.startDateTime, displayedComponents: [.date] )
                    }else {
                        Text("Start date & time?")
                        DatePicker("", selection: $event.startDateTime, displayedComponents: [.date, .hourAndMinute] )
                        Text("End date & time?")
                        DatePicker("", selection: $event.endDateTime, displayedComponents: [.date, .hourAndMinute] )
                    }
                    Picker(selection: $event.type, label: Text("Type")) {
                        Text("Academic").tag(0)
                        Text("Course").tag(1)
                    }.pickerStyle(SegmentedPickerStyle()).padding(.all , 4)
                    
                }
            }
            HStack {
                Button {
                    if isNew {
                        uurroosterDataStore.addEvent(event: event)
                    } else {
                        uurroosterDataStore.updateEvent(event: event)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    isNew ? Text("SAVE") : Text("UPDATE")
                }
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("CANCEL")
                }
            }
            
            Spacer()
        }.padding()
            .onAppear() {
                
            }
    }
}
