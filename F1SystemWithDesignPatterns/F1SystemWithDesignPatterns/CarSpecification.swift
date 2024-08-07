//
//  CarSpecification.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 05/08/24.
//

import Foundation

struct CarSpecification {
    var enginePower: Double
    var aerodynamics: Double
    var fuelEfficiency: Double
    var performanceScore: Double {
        enginePower * 0.5 + (1 / aerodynamics) * 100 + fuelEfficiency * 10
    }
}
