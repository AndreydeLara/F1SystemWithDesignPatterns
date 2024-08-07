//
//  Observer.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 05/08/24.
//

import Foundation

protocol Observer: AnyObject {
    func update(event: ObserverEvent)
}

enum ObserverEvent {
    case teamWasUpdated(old: Team, new: Team)
}
