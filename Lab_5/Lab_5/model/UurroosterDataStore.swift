//
//  UurroosterDataStore.swift
//  Uurrooster
//
//  Created by Dirk Hostens on 14/10/2022.
//

import Foundation

@Observable
class UurroosterDataStore {
    var uurrooster : [EventModel]
    
    init() {
        uurrooster = [EventModel]()
    }
    
    private func sort(){
        uurrooster.sort{ event1, event2 in
            event1.startDateTime > event2.startDateTime
        }
    }
    
    func addEvent(event: EventModel ){
        event.id = UUID().uuidString
        uurrooster.append(event)
        sort()
    }
    
    func updateEvent(event: EventModel ){
        for model in uurrooster {
            if event.id.elementsEqual(model.id){
                model.type = event.type
                model.allDay = event.allDay
                model.endDateTime = event.endDateTime
                model.location = event.location
                model.startDateTime = event.startDateTime
                model.title = event.title
            }
        }
        sort()
    }
    
    func deleteEvent(id: String) {
        //geeft een gefilterde lijst terug zonder het opgegeven element en stopt deze terug in uurrooster
        uurrooster = uurrooster.filter({ event in
            return !event.id.elementsEqual(id)
        })
    }
    
    func getEvent(id: String) -> EventModel {
        let filtered = uurrooster.filter({ event in
            return event.id.elementsEqual(id)
        })
        if filtered.count  > 0 {
            return filtered[0]
        } else {
            return EventModel()
        }
    }
    
    func loadData() async {
        //simulate async call
        do {
            print("⏳ Simulating 2-second load delay...")
            try await Task.sleep(for: .seconds(2)) // Simulate long load
            let data: [EventModelJson] = try load("uurrooster.json")
            uurrooster = data.map({ evenModelJson in
                evenModelJson.toEventModel()
            })
            sort()
            print("✅ Data loaded successfully.")
            
        } catch {
            print("❌ Failed to load uurrooster:", error)
            uurrooster = [EventModel]()
        }
    }

}

private struct EventModelJson: Hashable, Codable, Identifiable {
    var id:String = ""
    var allDay: Bool = false
    var title: String = ""
    var location: String? = nil
    var type: String = ""
    var startDateTime: String = ""
    var endDateTime: String = ""
    
    var formattedStartDateTime: String {
        get {
            return startDateTime.replacingOccurrences(of: "T", with: " ")
        }
    }
    var formattedEndDateTime: String {
        get {
            return endDateTime.replacingOccurrences(of: "T", with: " ")
        }
    }
    var formattedAllDayStartTime: String {
        get {
            return String(startDateTime.split(separator: "T")[0])
        }
    }
    func getEventInput() -> (title: String, location: String, allDay: Bool, startDate: Date, endDate: Date, type: Int ) {
        return (self.title, self.location == nil ? "" : location!, allDay, DateUtil.getDate(string: startDateTime), DateUtil.getDate(string: endDateTime), type.elementsEqual("academic") ? 0 : 1)
    }
    
    func toEventModel() -> EventModel {
        let eventModel = EventModel()
        eventModel.id = self.id
        eventModel.allDay = self.allDay
        eventModel.title = self.title
        eventModel.location = self.location ?? ""
        eventModel.startDateTime = DateUtil.getDate(string: self.startDateTime)
        eventModel.endDateTime = DateUtil.getDate(string: self.endDateTime)
        if self.type.elementsEqual("academic") {
            eventModel.type = 0
        } else {
            eventModel.type = 1
        }
        return eventModel
    }
}
