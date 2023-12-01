//
//  MultipleTimerView.swift
//  MultipleTimer
//
//  Created by brad on 12/1/23.
//

import SwiftUI

struct MultipleTimerView: View {
    @StateObject private var viewModel = MultipeTimerViewModel()
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    TabView(selection: $currentIndex) {
                        ForEach(0..<viewModel.timerItemStore.count, id: \.self) { index in
                            VStack{
                                HStack {
                                    Text("ID: \(viewModel.timerItemStore[index].id)")
                                        .lineLimit(2)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                                Spacer()
                                
                                Text("Count: \(viewModel.timerItemStore[index].count)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Spacer()
                            }
                            .padding()
                            .foregroundColor(.white)
                        }
                    }
                    .tabViewStyle(.page)
                }
                .frame(width: 300, height: 200)
            }
            .background(.pink)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 15)
            .frame(width: 300, height: 200)
            
            HStack {
                Button("Start") {
                    viewModel.startTimers()
                }
                .buttonStyle(.bordered)
                
                Button("Cancel") {
                    viewModel.stopTimer(index: currentIndex)
                    if viewModel.timerItemStore.count == 1 {
                        currentIndex = 0
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    MultipleTimerView()
}
