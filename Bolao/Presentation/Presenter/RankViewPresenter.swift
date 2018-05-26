//
//  RankViewPresenter.swift
//  Bolao
//
//  Created by Rafael Zane on 25/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class RankViewPresenter {
    
    static func allUsersHistoricAndRank(completion: @escaping ([((key: String, value: ([(LocalBet, MatchScore?)], Double)), Int)]) -> ()) {
        
        
        ServerAPI.fetchAll { (matches: [Match]?) in
            if(matches != nil ) {
                
                let historic = allUsersHistoric(matches: matches!)
                let sortedHistoric = historic.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.value.1 > rhs.value.1
                })
                var rank = 1
                var lastScore: Double? = nil
                var historicAndRank = [((key: String, value: ([(LocalBet, MatchScore?)], Double)), Int)]()
                for historic in sortedHistoric {
                    
                    if(lastScore != nil && historic.value.1 < lastScore!){
                        rank += 1
                    }
                    historicAndRank.append((historic, rank))
                    lastScore = historic.value.1
                }
                completion(historicAndRank)
            }
        }
    }
    
    static func allUsersHistoric(matches: [Match]) -> [String: ([(LocalBet, MatchScore?)], Double)] {
        var historic = [String: ([(LocalBet, MatchScore?)], Double)]()
        let users = UserPersistence.users
        let sortedMatches = matches.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.timeInterval < rhs.timeInterval
        })
        for user in users {
            let bets = user.bets
            var userScore = ScoreCalculator.score(of: user, in: matches)
            if(userScore == nil) {
                userScore = 0
            }
            var allMatchesBetsAndResults = [(LocalBet, MatchScore?)]()
            for match in sortedMatches {
                let bet = bets.first(where: { (bet) -> Bool in
                    return bet.match.id == match.id
                })
                if(bet != nil) {
                    let matchBetAndResult = (bet!, match.score)
                    allMatchesBetsAndResults.append(matchBetAndResult)
                    
                }
            }
            historic[user.name] = (allMatchesBetsAndResults, userScore!)
            
        }
        return historic
    }
    
    static func scoreOfUserInEachMatch(betsAndResults: [(LocalBet, MatchScore?)]) -> [Double?]? {
        
        var scores = [Double?]()
        var gotAScore = false
        for (bet, matchResult) in betsAndResults {
            if(matchResult != nil) {
                let score = ScoreCalculator.calculateBetScore(betResult: bet.betValues, result: matchResult!)
                scores.append(score)
                gotAScore = true
            } else {
                scores.append(nil)
            }
        }
        
        if(gotAScore) {
            return scores
        }
        return nil
    }
}
