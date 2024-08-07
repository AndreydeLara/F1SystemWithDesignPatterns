//
//  TeamRepository.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 03/08/24.
//

import Foundation

final class TeamRepository {
    
    static let shared = TeamRepository()
    
    private var teams: [Team] = []
    private var observers: [Observer] = []
    
    private init () { }
    
}

// MARK: - Subject functions
extension TeamRepository: Subject {
    func attach(_ observer: Observer) {
        observers.append(observer)
    }
    
    func detach(_ observer: Observer) {
        observers.removeAll { $0 === observer }
    }
    
    func notify(event: ObserverEvent) {
        for observer in observers {
            observer.update(event: event)
        }
    }
}

// MARK: - Team functions
extension TeamRepository {
    func getAllTeams() -> [Team] { teams }
    
    func addTeam(_ team: Team) {
        teams.append(team)
    }
    
    func update(team: Team) {
        guard let index = teams.firstIndex(where: { $0.name == team.name }) else { return }
        let oldTeam = teams[index]
        teams[index] = team
        
        notify(event: .teamWasUpdated(old: oldTeam, new: team))
    }
    
    func getTeam(by name: String) -> Team? {
        teams.first { $0.name == name }
    }
}

// MARK: - Pilot functions
extension TeamRepository {
    func getAllPilots() -> [Pilot] {
        teams.flatMap { [$0.firstPilot, $0.secondPilot] }
    }
    
    func getPilot(by name: String) -> Pilot? {
        getAllPilots().first { $0.name == name }
    }
    
    func update(pilot: Pilot) {
        guard let index = teams.firstIndex(where: { $0.name == pilot.team }) else { return }
        
        if pilot.isFirstPilot {
            teams[index].firstPilot = pilot
        } else {
            teams[index].secondPilot = pilot
        }
    }
}
