//
//  LocalBet.swift
//  Bolao
//
//  Created by Rafael Zane on 23/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class LocalBet {
    
    private(set) var betValues : MatchScore
    private(set) var match : Match
    private(set) var score : Double?
    
    init(betValues: MatchScore, match: Match) {
        self.betValues = betValues
        self.match = match
    }
}
