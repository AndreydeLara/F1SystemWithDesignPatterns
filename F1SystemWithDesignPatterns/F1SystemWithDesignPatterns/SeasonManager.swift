//
//  SeasonManager.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 03/08/24.
//

import Foundation

final class SeasonManager {
    
    private let teamRepository = TeamRepository.shared
    
    init() {
        teamRepository.attach(CarSpecificationObserver())
    }
}

extension SeasonManager {
    func addTeam(
        name: String,
        firstPilotName: String,
        secondPilotName: String,
        carName: String
    ) throws {
        let thereIsExistingGroup = teamRepository.getAllTeams().contains(where: { $0.name == name })
        
        guard !thereIsExistingGroup else { throw ServiceError.existingTeam }
        
        let team = try TeamBuilder(name: name)
            .addPilots(firstPilot: firstPilotName, secondPilot: secondPilotName)
            .addCar(carName)
            .build()
        
        teamRepository.addTeam(team)
    }
}

extension SeasonManager {
    func registerRace(raceName: String) throws {
        var pilotScores = try teamRepository.getAllPilots().map { pilot in
            guard let team = teamRepository.getTeam(by: pilot.team) else {
                throw ServiceError.teamNotFound(pilot.team)
            }
            let performanceScore = team.car.specification.performanceScore
            let randomFactor = Double.random(in: 0.8...1.2)
            let adjustedScore = performanceScore * randomFactor
            return (pilot: pilot, score: adjustedScore)
        }

        pilotScores.sort { $0.score > $1.score }
        
        let pointsTable = [
            (position: "1º", point: 25),
            (position: "2º", point: 18),
            (position: "3º", point: 15),
            (position: "4º", point: 12),
            (position: "5º", point: 10),
            (position: "6º", point: 8),
            (position: "7º", point: 6),
            (position: "8º", point: 4),
            (position: "9º", point: 2),
            (position: "10º", point: 1)
        ]

        for index in pilotScores.indices {
            var pilot = pilotScores[index].pilot
            let points = pointsTable[index].point
            let position = pointsTable[index].position

            pilot.seasonPoints += points
            pilot.racingHistory.append("\(position) in \(raceName)")
            teamRepository.update(pilot: pilot)
        }
    }
}

extension SeasonManager {
    func updateCarSpecification(
        teamName: String,
        enginePower: Double? = nil,
        aerodynamics: Double? = nil,
        fuelEfficiency: Double? = nil
    ) throws {
        guard var team = teamRepository.getAllTeams().first(where: { $0.name == teamName }) else {
            throw ServiceError.teamNotFound(teamName)
        }
        
        if let enginePower {
            team.car.specification.enginePower = enginePower
        }
        
        if let aerodynamics {
            team.car.specification.aerodynamics = aerodynamics
        }
        
        if let fuelEfficiency {
            team.car.specification.fuelEfficiency = fuelEfficiency
        }
        
        teamRepository.update(team: team)
    }
}

extension SeasonManager {
    func printDriversPointsTable() { 
        var pilots = teamRepository.getAllPilots()
        pilots.sort { $0.seasonPoints > $1.seasonPoints }
        
        print("------------ Drivers Points Table ------------")
        for (index, pilot) in pilots.enumerated() {
            print("\(index+1)º - \(pilot.name) - \(pilot.seasonPoints)")
        }
        print("----------------------------------------------\n\n")
    }
    
    func printConstructorsPointsTable() {
        var teams = teamRepository.getAllTeams()
            .map {
                (name: $0.name, points: ($0.firstPilot.seasonPoints + $0.secondPilot.seasonPoints))
            }
        
        teams.sort { $0.points > $1.points }
        
        print("--------- Constructors Points Table ---------")
        for (index, team) in teams.enumerated() {
            print("\(index+1)º - \(team.name) - \(team.points)")
        }
        print("---------------------------------------------\n\n")
    }
    
    func printDriversRaceHistory() {
        var pilots = teamRepository.getAllPilots()
        pilots.sort { $0.seasonPoints > $1.seasonPoints }
        
        for (index, pilot) in pilots.enumerated() {
            print("--------- \(pilot.name) Race History ---------")
            print("Position: \(index+1)º")
            print("Season Points: \(pilot.seasonPoints)\n")
            pilot.racingHistory.forEach { print($0) }
            print("\n")
        }
    }
}

extension SeasonManager {
    enum ServiceError: Error, LocalizedError {
        case existingTeam
        case teamNotFound(String)
        
        var errorDescription: String? {
            switch self {
                case .existingTeam:
                    return "This team already exists"
                case .teamNotFound(let teamName):
                    return "Team not found: \(teamName)"
            }
        }
    }
}
