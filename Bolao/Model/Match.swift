//
//  Match.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Match: Codable, DBEntity {

    private(set) var id: Int64
    private(set) var timeInterval: Double
    private(set) var championshipRound: String
    private(set) var playoff: Bool
    private(set) var stadium: String
    private(set) var city: String
    private(set) var championshipGroup: String?
    
    // MARK: Relationship
    private(set) var firstTeam: Team
    private(set) var secondTeam: Team
    private(set) var score: MatchScore?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case timeInterval = "date"
        case championshipRound = "championshipRound"
        case championshipGroup = "championshipGroup"
        case playoff = "playoff"
        case firstTeam = "firstTeam"
        case secondTeam = "secondTeam"
        case score = "score"
        case stadium = "stadium"
        case city = "city"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        timeInterval = try values.decode(Double.self, forKey: .timeInterval)
        championshipRound = try values.decode(String.self, forKey: .championshipRound)
        playoff = try values.decode(Bool.self, forKey: .playoff)
        firstTeam = try values.decode(Team.self, forKey: .firstTeam)
        secondTeam = try values.decode(Team.self, forKey: .secondTeam)
        score = try values.decode(MatchScore?.self, forKey: .score)
        stadium = try values.decode(String.self, forKey: .stadium)
        city = try values.decode(String.self, forKey: .city)
        championshipGroup = try values.decode(String?.self, forKey: .championshipGroup)
    }
    
    init(id: Int64, timeInterval: Double, championshipRound: String, playoff: Bool, firstTeam: Team, secondTeam: Team, score: MatchScore, stadium : String, city: String, group: String) {
        self.id = id
        self.timeInterval = timeInterval
        self.championshipRound = championshipRound
        self.playoff = playoff
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
        self.score = score
        self.stadium = stadium
        self.city = city
        self.championshipGroup = group
    }
    

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(timeInterval, forKey: .timeInterval)
        try container.encode(championshipRound, forKey: .championshipRound)
        try container.encode(championshipGroup, forKey: .championshipGroup)
        try container.encode(playoff, forKey: .playoff)
        try container.encode(firstTeam, forKey: .firstTeam)
        try container.encode(secondTeam, forKey: .secondTeam)
        try container.encode(score, forKey: .score)
        try container.encode(stadium, forKey: .stadium)
        try container.encode(city, forKey: .city)
    }
    
    // MARK: set functions
    func setId(id: Int64) {
        self.id = id
    }

    func setMatchDate(timeInterval: Double) {
        self.timeInterval = timeInterval
    }

    func setChampionshipRound(championshipRound: String) {
        self.championshipRound = championshipRound
    }

    func setPlayoff(playoff: Bool) {
        self.playoff = playoff
    }

    func setFirstTime(firstTeam: Team) {
        self.firstTeam = firstTeam
    }

    func setSecondTeam(secondTeam: Team) {
        self.secondTeam = secondTeam
    }

    func setScore(score: MatchScore) {
        self.score = score
    }


    static func urlExtention() -> String {
        return "matches"
    }
    
}

extension Match: Equatable {

    
    static func == (lhs: Match, rhs: Match) -> Bool {
        if(lhs.id == rhs.id) {
            return true
        }
        return false
    }
}

