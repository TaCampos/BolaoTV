//
//  Bet.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Bet: NSObject {

    private(set) var id: Int64
    private(set) var multiplier: Int

    // MARK: Relationship
    private(set) var user: User
    private(set) var match: Match
    private(set) var betScore: MatchScore

    init(id: Int64, multiplier: Int, user: User, match: Match, betScore: MatchScore) {
        self.id = id
        self.multiplier = multiplier
        self.user = user
        self.match = match
        self.betScore = betScore
    }

    // MARK: set functions
    func setId(id: Int64) {
        self.id = id
    }

    func setMultiplier(multiplier: Int) {
        self.multiplier = multiplier
    }

    func setUser(user: User) {
        self.user = user
    }

    func setMatch(match: Match) {
        self.match = match
    }

    func setBetScore(betScore: MatchScore) {
        self.betScore = betScore
    }
}
