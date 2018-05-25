//
//  LocalUser.swift
//  Bolao
//
//  Created by Rafael Zane on 23/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class LocalUser {
    
    private(set) var name: String
    private(set) var bets: [LocalBet]
    private(set) var totalScore: Double
    
    init(name: String, bets: [LocalBet]) {
        self.name = name
        self.bets = bets
        self.totalScore = 0
    }
    
    func addBet(_ bet: LocalBet) {
        bets.append(bet)
    }
    
    func removeBet(_ bet: LocalBet) {
        for index in bets.startIndex..<bets.endIndex {
            if bets[index].match == bet.match {
                bets.remove(at: index)
                return
            }
        }
    }
}
