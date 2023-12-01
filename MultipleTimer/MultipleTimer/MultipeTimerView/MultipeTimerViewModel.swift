//
//  MultipeTimerViewModel.swift
//  MultipleTimer
//
//  Created by brad on 12/1/23.
//

import Foundation
import Combine

final class MultipeTimerViewModel: ObservableObject {
    @Published var timerItemStore: [TimerItem] = []
    
    func startTimers() {
        let uuid = UUID()
        
        let timerPublish = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.updateTimers(id: uuid)
            }
        
        let timerItem = TimerItem(
            id: uuid,
            count: 0,
            subscriptions: timerPublish
        )
        timerItemStore.append(timerItem)
    }
    
    func stopTimer(index: Int) {
        guard timerItemStore.isEmpty == false else {
            return
        }
        timerItemStore.remove(at: index)
    }
}

private extension MultipeTimerViewModel {
    func updateTimers(id: UUID) {
        guard let currentIndex = timerItemStore.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        timerItemStore[currentIndex].count += 1
    }
}
