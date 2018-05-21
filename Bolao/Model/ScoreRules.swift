//
//  ScoreRules.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class ScoreRules: NSObject {

    private(set) var id: Int64
    private(set) var pointsCorrectWinner: Int
    private(set) var pointsFirstTeamGoals: Int
    private(set) var pointsSecondTeamGoals: Int
    private(set) var pointsGoalsDifference: Int
    private(set) var pointsExactResult: Int
    private(set) var unlikelyResultMultiplier: Bool

    private(set) var validTeams: [Team]?

    init(id: Int64, pointsCorrectWinner: Int, pointsFirstTeamGoals: Int, pointsSecondTeamGoals: Int, pointsGoalsDifference: Int, pointsExactResult: Int, unlikelyResultMultiplier: Bool) {
        self.id = id
        self.pointsCorrectWinner = pointsCorrectWinner
        self.pointsFirstTeamGoals = pointsFirstTeamGoals
        self.pointsSecondTeamGoals = pointsSecondTeamGoals
        self.pointsGoalsDifference = pointsGoalsDifference
        self.pointsExactResult = pointsExactResult
        self.unlikelyResultMultiplier = unlikelyResultMultiplier
    }

    // MARK: set functions
    func setId(id: Int64) {
        self.id = id
    }

    func setPointsCorrectWinner(pointsCorrectWinner: Int) {
        self.pointsCorrectWinner = pointsCorrectWinner
    }

    func setPointsFirstTeamGoals(pointsFirstTeamGoals: Int) {
        self.pointsFirstTeamGoals = pointsFirstTeamGoals
    }

    func setPointsSecondTeamGoals(pointsSecondTeamGoals: Int) {
        self.pointsSecondTeamGoals = pointsSecondTeamGoals
    }

    func setPointsGoalsDifference(pointsGoalsDifference: Int) {
        self.pointsGoalsDifference = pointsGoalsDifference
    }

    func setPointsExactResult(pointsExactResult: Int) {
        self.pointsExactResult = pointsExactResult
    }

    func setUnlikelyResultMultiplier(unlikelyResultMultiplier: Bool) {
        self.unlikelyResultMultiplier = unlikelyResultMultiplier
    }


    // MARK: Add and remove functions
    func addValidTeams(newValidTeams: Team) {
        self.validTeams?.append(newValidTeams)
    }

    func removeValidTeams(atIndex index: Int) -> Team {
        return (self.validTeams?.remove(at: index))!
    }
}
