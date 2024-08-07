//
//  main.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 03/08/24.
//

import Foundation

let seasonManager = SeasonManager()

try seasonManager.addTeam(
    name: "Red Bull Racing",
    firstPilotName: "Max Verstappen",
    secondPilotName: "Sergio Pérez",
    carName: "RB20"
)

try seasonManager.addTeam(
    name: "Mercedes",
    firstPilotName: "Lewis Hamilton",
    secondPilotName: "George Russell",
    carName: "F1 W15"
)

try seasonManager.addTeam(
    name: "Ferrari",
    firstPilotName: "Charles Leclerc",
    secondPilotName: "Carlos Sainz",
    carName: "SF-24"
)

try seasonManager.addTeam(
    name: "McLaren",
    firstPilotName: "Lando Norris",
    secondPilotName: "Oscar Piastri",
    carName: "MCL38"
)

try seasonManager.addTeam(
    name: "Aston Martin",
    firstPilotName: "Fernando Alonso",
    secondPilotName: "Lance Stroll",
    carName: "AMR24"
)

try seasonManager.registerRace(raceName: "Bahrain International Circuit")

try seasonManager.updateCarSpecification(teamName: "Ferrari", aerodynamics: 0.2)

try seasonManager.registerRace(raceName: "Jeddah Corniche Circuit")
try seasonManager.registerRace(raceName: "Albert Park Circuit")
try seasonManager.registerRace(raceName: "Imola Circuit (Autodromo Internazionale Enzo e Dino Ferrari)")

try seasonManager.updateCarSpecification(teamName: "Red Bull Racing", enginePower: 1100)
try seasonManager.updateCarSpecification(teamName: "Mercedes", fuelEfficiency: 5.5)

try seasonManager.registerRace(raceName: "Circuit de Monaco")
try seasonManager.registerRace(raceName: "Circuit de Barcelona-Catalunya")
try seasonManager.registerRace(raceName: "Circuit Gilles Villeneuve")
try seasonManager.registerRace(raceName: "Red Bull Ring")

seasonManager.printDriversPointsTable()
seasonManager.printConstructorsPointsTable()
seasonManager.printDriversRaceHistory()
