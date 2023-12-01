//
//  ContentView.swift
//  MultipleTimer
//
//  Created by brad on 11/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                MultipleTimerView()
            }
            .navigationTitle("Multipe Timer")
        }
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
