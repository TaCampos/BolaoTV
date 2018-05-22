//
//  Match.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Match: Codable {

    private(set) var id: Int64
    private(set) var date: Date
    private(set) var championshipRound: String
    private(set) var playoff: Bool

    // MARK: Relationship
    private(set) var firstTeam: Team
    private(set) var secondTeam: Team
    private(set) var score: MatchScore
    private(set) var championship: Championship

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case championshipRound = "championshipRound"
        case playoff = "playoff"
        case firstTeam = "firstTeam"
        case secondTeam = "secondTeam"
        case score = "score"
        case championship = "championship"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        date = try values.decode(Date.self, forKey: .date)
        championshipRound = try values.decode(String.self, forKey: .championshipRound)
        playoff = try values.decode(Bool.self, forKey: .playoff)
        firstTeam = try values.decode(Team.self, forKey: .firstTeam)
        secondTeam = try values.decode(Team.self, forKey: .secondTeam)
        score = try values.decode(MatchScore.self, forKey: .score)
        championship = try values.decode(Championship.self, forKey: .championship)
        
    }
    
    init(id: Int64, date: Date, championshipRound: String, playoff: Bool, firstTeam: Team, secondTeam: Team, score: MatchScore, championship: Championship) {
        self.id = id
        self.date = date
        self.championshipRound = championshipRound
        self.playoff = playoff
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
        self.score = score
        self.championship = championship
    }

    // MARK: set functions
    func setId(id: Int64) {
        self.id = id
    }

    func setMatchDate(date: Date) {
        self.date = date
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

    func setChampioship(championship: Championship) {
        self.championship = championship
    }

}

