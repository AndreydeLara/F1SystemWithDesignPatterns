//
//  CarSpecificationObserver.swift
//  F1SystemWithDesignPatterns
//
//  Created by Andrey de Lara on 05/08/24.
//

import Foundation

final class CarSpecificationObserver: Observer {
    func update(event: ObserverEvent) {
        switch event {
            case .teamWasUpdated(let oldTeam, let newTeam):
                let old = oldTeam.car.specification
                let new = newTeam.car.specification
                
                var news: [String] = []
                
                if old.enginePower < new.enginePower {
                    news.append("🚀 -- NEWS FLASH -- 🚀")
                    news.append("\(newTeam.name) boosts engine power! Expect better performance in upcoming races! 🏎️💨\n")
                } else if old.enginePower > new.enginePower {
                    news.append("🚀 -- NEWS FLASH -- 🚀")
                    news.append("\(newTeam.name) reduces engine power. Performance might drop in the next races. ⚠️\n")
                }
                
                if old.aerodynamics < new.aerodynamics {
                    news.append("🌬️ -- AERODYNAMICS UPDATE -- 🌬️")
                    news.append("\(newTeam.name) downgrades aerodynamics. This could affect their speed. ⚠️\n")
                } else if old.aerodynamics > new.aerodynamics {
                    news.append("🌬️ -- AERODYNAMICS UPDATE -- 🌬️")
                    news.append("\(newTeam.name) enhances aerodynamics. Better handling and speed expected. 🏁\n")
                }
                
                if old.fuelEfficiency < new.fuelEfficiency {
                    news.append("⛽ -- FUEL EFFICIENCY NEWS -- ⛽")
                    news.append("\(newTeam.name) improves fuel efficiency. Longer stints with fewer pit stops anticipated. ⏱️\n")
                } else if old.fuelEfficiency > new.fuelEfficiency {
                    news.append("⛽ -- FUEL EFFICIENCY NEWS -- ⛽")
                    news.append("\(newTeam.name) lowers fuel efficiency. More frequent pit stops likely. 🛑\n")
                }
                
                guard news.count > 0 else { return }
                news.append("\n")
                
                news.forEach { print($0) }
        }
    }
}
