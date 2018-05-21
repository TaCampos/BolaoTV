//
//  Match.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Match: NSObject {

    private(set) var id: Int64
    private(set) var date: NSDate
    private(set) var championshipRound: String
    private(set) var playoff: Bool

    // MARK: Relationship
    private(set) var firstTeam: Team
    private(set) var secondTeam: Team
    private(set) var score: MatchScore
    private(set) var championship: Championship

    init(id: Int64, date: NSDate, championshipRound: String, playoff: Bool, firstTeam: Team, secondTeam: Team, score: MatchScore, championship: Championship) {
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

    func setMatchDate(date: NSDate) {
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

