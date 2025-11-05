//
//  ContentView.swift
//  Lab_5
//
//  Created by Jarne Adam on 04/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State var uurroosterDataStore = UurroosterDataStore()
    
    var body: some View {
        UurroosterList().environment(uurroosterDataStore)
    }
}
