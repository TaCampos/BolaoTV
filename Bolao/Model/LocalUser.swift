//
//  LocalUser.swift
//  Bolao
//
//  Created by Rafael Zane on 23/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class LocalUser: Codable {
    
    private(set) var name: String
    private(set) var bets: [LocalBet]
    private(set) var totalScore: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case bets = "bets"
        case totalScore = "totalScore"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        bets = try values.decode([LocalBet].self, forKey: .bets)
        totalScore = try values.decode(Double.self, forKey: .totalScore)
    }
    
    init(name: String, bets: [LocalBet]) {
        self.name = name
        self.bets = bets
        self.totalScore = 0
    }
    
    func addBet(_ bet: LocalBet) {
        bets.append(bet)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(bets, forKey: .bets)
        try container.encode(totalScore, forKey: .totalScore)
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
