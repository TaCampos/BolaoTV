//
//  Bet.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Bet: Codable {

    private(set) var id: Int64
    private(set) var multiplier: Int

    // MARK: Relationship
    private(set) var user: User
    private(set) var match: Match
    private(set) var betScore: MatchScore

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case match = "match"
        case betScore = "betScore"
        case multiplier = "multiplier"
        case user = "user"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        match = try values.decode(Match.self, forKey: .match)
        betScore = try values.decode(MatchScore.self, forKey: .betScore)
        multiplier = try values.decode(Int.self, forKey: .multiplier)
        user = try values.decode(User.self, forKey: .user)
    }
    
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
