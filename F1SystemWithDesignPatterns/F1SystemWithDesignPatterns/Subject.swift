//
//  Subject.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 05/08/24.
//

import Foundation

protocol Subject: AnyObject {
    func attach(_ observer: Observer)
    func detach(_ observer: Observer)
    func notify(event: ObserverEvent)
}
