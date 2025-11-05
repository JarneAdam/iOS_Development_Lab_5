//
//  UurroosterDetailView.swift
//  Lab_5
//
//  Created by Jarne Adam on 05/11/2025.
//

import SwiftUI

struct UurroosterDetailView: View {
    var event: EventModel
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Spacer()
                    Text(event.title)
                        .foregroundColor(Color.white)
                        .padding( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/, 8)
                    Spacer()
                }.background(Color.red).cornerRadius(10)
            }.padding(.all, 5)
            VStack{
                Divider()
                HStack{
                    Text(event.location)
                    Spacer()
                }.padding(.bottom, 5)
                if event.allDay {
                    HStack {
                        Text("De volledige dag")
                        Spacer()
                        Text(DateUtil.formatDate(date: event.startDateTime))
                    }
                } else {
                    HStack {
                        Text("Start")
                        Spacer()
                        Text(DateUtil.formatDateTime(date: event.startDateTime))
                    }.padding(.bottom, 5)
                    HStack {
                        Text("Einde")
                        Spacer()
                        Text(DateUtil.formatDateTime(date: event.endDateTime))
                    }
                }
                Divider()
            }
        }
    }
}
