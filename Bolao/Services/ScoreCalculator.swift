//
//  ScoreCalculator.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class ScoreCalculator {
    static func score(of user: LocalUser, in match: Match) -> Double? {
        guard let matchScore = match.score else {
            return 0
        }
        
        for bet in user.bets {
            if bet.match.id == match.id {
                if bet.score == nil {
                    return 0
                }
                return calculateBetScore(betResult: bet.betValues, result: matchScore)
            }
        }
        return 0
    }
    
    static func score(of user: LocalUser, in matches: [Match]) -> Double? {
        var score = 0.0
        for match in matches {
            score += ScoreCalculator.score(of: user, in: match) ?? 0
        }
        return 0
    }

    static func score(of users: [LocalUser], in match: Match) -> [(LocalUser, Double?)] {
        var userScores: [(LocalUser, Double?)] = []
        for user in users {
            let score = ScoreCalculator.score(of: user, in: match)
            userScores.append((user, score))
        }
        return userScores
    }
    
    static func score(of users: [LocalUser], in matches: [Match]) -> [(LocalUser, Double?)] {
        var userScores: [(LocalUser, Double?)] = []
        for user in users {
            let score = ScoreCalculator.score(of: user, in: matches)
            userScores.append((user, score))
        }
        return userScores
    }
    
    static func calculateBetScore(betResult: MatchScore, result: MatchScore) -> Double {
        
        // check if it was the correct winner
        if (betResult.firstTeamScore > betResult.secondTeamScore && result.firstTeamScore > result.secondTeamScore)
            || (betResult.firstTeamScore < betResult.secondTeamScore && result.firstTeamScore < result.secondTeamScore)
            || (betResult.firstTeamScore == betResult.secondTeamScore && result.firstTeamScore == result.secondTeamScore) {
            
            if (betResult.firstTeamScore == result.firstTeamScore &&
                betResult.secondTeamScore == betResult.secondTeamScore) {
                return 5
            } else {
                return 3
            }
        }
        
        return 0
    }
}
