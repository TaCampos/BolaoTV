//
//  MatchScore.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class MatchScore: NSObject {

    private(set) var id: Int64
    private(set) var firstTeamScore: Int
    private(set) var secondTeamScore: Int
    private(set) var firstTeamPenaltiesScore: Int?
    private(set) var secondTeamPenaltiesScore: Int?
    private(set) var firstTeamScoreAuthors: [String]?
    private(set) var secondTeamScoreAuthors: [String]?

    init(id: Int64, firstTeamScore: Int, secondTeamScore: Int) {
        self.id = id
        self.firstTeamScore = firstTeamScore
        self.secondTeamScore = secondTeamScore
    }

    // MARK: set functions
    func setId(id: Int64) {
        self.id = id
    }

    func setFirstTeamScore(firstTeamScore: Int) {
        self.firstTeamScore = firstTeamScore
    }

    func setSecondTeamScore(secondTeamScore: Int) {
        self.secondTeamScore = secondTeamScore
    }

    func setFirstTeamPenaltiesScore(firstTeamPenaltiesScore: Int?) {
        self.firstTeamPenaltiesScore = firstTeamPenaltiesScore
    }

    func setSecondTeamPenaltiesScore(secondTeamPenaltiesScore: Int?) {
        self.secondTeamPenaltiesScore = secondTeamPenaltiesScore
    }

    // MARK: add and remove functions
    func addFirstTeamScoreAuthors(newScoreAuthor: String) {
        self.firstTeamScoreAuthors?.append(newScoreAuthor)
    }

    func addSecondTeamScoreAuthors(newScoreAuthor: String) {
        self.secondTeamScoreAuthors?.append(newScoreAuthor)
    }

    // TODO: remove ScoreAuthor??


}

