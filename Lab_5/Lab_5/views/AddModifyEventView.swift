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
        Text("AddModifyEventView")
    }
}
