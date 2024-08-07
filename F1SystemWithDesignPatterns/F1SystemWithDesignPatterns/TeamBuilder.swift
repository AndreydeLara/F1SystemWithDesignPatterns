//
//  TeamBuilder.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 03/08/24.
//

import Foundation

final class TeamBuilder {
    
    private var teamName: String
    private var firstPilot: Pilot?
    private var secondPilot: Pilot?
    private var car: Car?
    
    init(name: String) {
        self.teamName = name
    }
    
    @discardableResult
    func addPilots(firstPilot: String, secondPilot: String) -> TeamBuilder {
        self.firstPilot = .init(name: firstPilot, team: teamName, isFirstPilot: true)
        self.secondPilot = .init(name: secondPilot, team: teamName, isFirstPilot: false)
        return self
    }
    
    @discardableResult
    func addCar(_ car: String) -> TeamBuilder {
        let defaultSpecification = CarSpecification(enginePower: 1000, aerodynamics: 0.3, fuelEfficiency: 5)
        self.car = .init(name: car, team: teamName, specification: defaultSpecification)
        return self
    }
    
    func build() throws -> Team {
        guard let firstPilot,
              let secondPilot,
              let car
        else {
            throw BuilderError.failureToCreateTeam
        }
        
        resetData()
        
        return Team(
            name: teamName,
            firstPilot: firstPilot,
            secondPilot: secondPilot,
            car: car
        )
    }
    
    private func resetData() {
        firstPilot = nil
        secondPilot = nil
        car = nil
    }
}

extension TeamBuilder {
    enum BuilderError: Error, LocalizedError {
        case failureToCreateTeam
        
        var errorDescription: String? { "Missing information to create a Team" }
    }
}
