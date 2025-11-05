//
//  UurroosterList.swift
//  Lab_5
//
//  Created by Jarne Adam on 05/11/2025.
//

import SwiftUI

struct UurroosterList: View {
    @Environment(UurroosterDataStore.self) private var uurroosterDataStore
    @State private var selectedEvent: EventModel?
    @State var loading = true
        
    var body: some View {
        NavigationSplitView{
            if loading {
                ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
            } else {
                List(uurroosterDataStore.uurrooster, id:\.self,  selection: $selectedEvent) { event in
                    VStack {
                        HStack{
                            if event.allDay {
                                Text(DateUtil.formatDate(date: event.startDateTime)).font(.headline)
                            } else {
                                Text(DateUtil.formatDateTime(date: event.startDateTime)).font(.headline)
                            }
                            Spacer()
                        }
                        HStack{
                            Text(event.title).font(.subheadline)
                            Spacer()
                        }
                    }
                }.toolbar() {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink {
                            AddModifyEventView(isNew: true, event: EventModel())
                        } label: {
                            Text("+")
                        }
                    }
                }
            }
        } detail: {
            if let selectedEvent {
                UurroosterDetailView(event: selectedEvent)
            } else {
                Text("Selecteer event")
            }
        }
        .task {
            await uurroosterDataStore.loadData()
            loading = false
        }
    }
}
