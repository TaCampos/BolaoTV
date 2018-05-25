//
//  RankViewPresenter.swift
//  Bolao
//
//  Created by Rafael Zane on 25/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class RankViewPresenter {
    
    static func allUsersHistoricAndRank(completion: @escaping ([((key: String, value: ([(MatchScore, MatchScore?)], Double)), Int)]) -> ()) {
        
        
        ServerAPI.fetchAll { (matches: [Match]?) in
            if(matches != nil ) {
                
                let historic = allUsersHistoric(matches: matches!)
                let sortedHistoric = historic.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.value.1 > rhs.value.1
                })
                var rank = 1
                var lastScore: Double? = nil
                var historicAndRank = [((key: String, value: ([(MatchScore, MatchScore?)], Double)), Int)]()
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
    
    static func allUsersHistoric(matches: [Match]) -> [String: ([(MatchScore, MatchScore?)], Double)] {
        var historic = [String: ([(MatchScore, MatchScore?)], Double)]()
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
            var allMatchesBetsAndResults = [(MatchScore, MatchScore?)]()
            for match in sortedMatches {
                let bet = bets.first(where: { (bet) -> Bool in
                    return bet.match.id == match.id
                })
                if(bet != nil) {
                    let matchBetAndResult = (bet!.betValues, match.score)
                    allMatchesBetsAndResults.append(matchBetAndResult)
                    
                }
            }
            historic[user.name] = (allMatchesBetsAndResults, userScore!)
            
        }
        return historic
    }
}
