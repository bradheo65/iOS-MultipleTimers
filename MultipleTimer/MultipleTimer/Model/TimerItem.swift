//
//  TimerItem.swift
//  MultipleTimer
//
//  Created by brad on 12/1/23.
//

import Foundation
import Combine

struct TimerItem: Identifiable {
    var id: UUID
    var count: Int
    var subscriptions: AnyCancellable?
}
