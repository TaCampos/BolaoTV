//
//  LocalBet.swift
//  Bolao
//
//  Created by Rafael Zane on 23/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class LocalBet: Codable {
    
    private(set) var betValues : MatchScore
    private(set) var match : Match
    private(set) var score : Double?
    
    enum CodingKeys: String, CodingKey {
        case betValues = "betValues"
        case match = "match"
        case score = "score"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        match = try values.decode(Match.self, forKey: .match)
        betValues = try values.decode(MatchScore.self, forKey: .betValues)
        score = try values.decode(Double?.self, forKey: .score)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(betValues, forKey: .betValues)
        try container.encode(match, forKey: .match)
        try container.encode(score, forKey: .score)
    }
    
    init(betValues: MatchScore, match: Match) {
        self.betValues = betValues
        self.match = match
    }
}
