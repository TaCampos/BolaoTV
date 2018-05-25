//
//  GameOverviewPresenter.swift
//  Bolao
//
//  Created by Rafael Zane on 23/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class GameOverviewPresenter {
    
    private var currentMatch: Match? = nil
    
    private var users: [LocalUser]?
    
    
    /// This function updates the current match that the presenter is using for getting all other informations.
    ///
    /// - Parameter newValue: the new current match.
    func updateCurrentMatch(newValue: Match) {
        self.currentMatch = newValue
    }
    
    
    /// Fetch all matches.
    ///
    /// - Parameters:
    ///   - sorted: indicates if matches should be sorted by date or not.
    ///   - completion: clousure that will receive all matches.
    func nextMatches(sorted: Bool, completion: @escaping ([Match]) -> ()) {
        ServerAPI.fetchAll { (matches: [Match]?) in
            if(matches != nil ) {
                if(sorted) {
                    let sortedMatches = matches!.sorted(by: { (lhs, rhs) -> Bool in
                        return lhs.timeInterval < rhs.timeInterval
                    })
                    completion(sortedMatches)
                } else {
                    completion(matches!)
                }
            } else {
                completion([Match]())
            }
        }
    }
    
    
    /// Add a bet to a user in the current match. Create a new user if it does not exist yet.
    ///
    /// - Parameters:
    ///   - name: name of the user.
    ///   - newUser: indicates if it is a new user.
    ///   - firstTeamScore: the score the user bet for the first team.
    ///   - secondTeamScore: the score the user bet for the second team.
    func newBetByUser(with name: String, newUser: Bool, firstTeamScore: Int, secondTeamScore: Int) {
        let matchScore = MatchScore(id: 0, firstTeamScore: firstTeamScore, secondTeamScore: secondTeamScore)
        let newBet = LocalBet(betValues: matchScore, match: currentMatch!)
        
        if(newUser) {
            var bets = [LocalBet]()
            bets.append(newBet)
            let user = LocalUser(name: name, bets: bets)
            users!.append(user)
            UserPersistence.updateUsers(users!)
        } else {
            for user in users! {
                if(user.name == name) {
                    for bet in user.bets {
                        if(bet.match == newBet.match) {
                            return
                        }
                    }
                    user.addBet(newBet)
                    return
                }
            }
        }
    }
    
    

    /// Fetch all users and their bets.
    ///
    /// - Returns: a dictionary with the user name as key and a tuple representing the bet they made in the current match.
    func usersNamesAndBets() -> [String: (Int, Int)] {
        users = UserPersistence.users
        var usersDict = [String: (Int, Int)]()
        for user in users! {
            for bet in user.bets {
                if(bet.match == currentMatch) {
                    usersDict[user.name] = (bet.betValues.firstTeamScore, bet.betValues.secondTeamScore)
                    break
                }
            }
        }
        return usersDict
    }
    
    /// Calculates the score of an user in the current match.
    ///
    /// - Parameter user: the name of the user
    /// - Returns: the score if user bet in the current match or nil otherwise. If user doesn't exist, returns nil.
    func score(of user: String) -> Double? {
        
        for _user in users! {
            if(_user.name == user) {
                return ScoreCalculator.score(of: _user, in: currentMatch!)
            }
        }
        return nil
    }
    
    
    /// Check if an user with this name already exists.
    ///
    /// - Parameter name: the name of the user.
    /// - Returns: true if user already exists, false otherwise.
    func checkUserWithNameExists(name: String) -> Bool {
        for user in users! {
            if(user.name == name) {
                return true
            }
        }
        return false
    }
    
    
    /// Check if user already bet a result in the current match.
    ///
    /// - Parameter name: name of the user.
    /// - Returns: true if user already bet a result in the current match, false otherwise.
    func checkUserAlreadyBetInMatch(name: String) -> Bool {
        for user in users! {
            if(user.name == name) {
                for bet in user.bets {
                    if(bet.match == currentMatch) {
                        return true
                    }
                }
                return false
            }
        }
        return false
    }
    
    
    /// Evaluate the score of users in the current match and returns the rank of an especific user.
    ///
    /// - Parameter user: name of the user.
    /// - Returns: the user rank in this match. Returns nil if the user has no score in the current match.
    func rank(of user: String) -> Int? {
        if let usersRank = allUsersRank() {
        
            for (name, rank) in usersRank {
                if(name == user) {
                    return rank
                }
            }
        }
        return nil
    }
    
    
    /// Evaluate the score of the users in the current match and returns the rank of all users. If the match didn't happen yet, the return is nil.
    ///
    /// - Returns: the rank of all users that bet in this match.
    func allUsersRank() -> [(key: String, value: Int)]? {
        
        if(currentMatch!.timeInterval < Date().timeIntervalSince1970) {
            return nil
        }
        
        var usersScoresDict = [String: Double]()
        for user in users! {
            let userScore = score(of: user.name)
            if(userScore != nil) {
                usersScoresDict[user.name] = userScore!
            }
        }
        
        let sortedDict = usersScoresDict.sorted { (lhs, rhs) -> Bool in
            return lhs.value > rhs.value
        }
        
        var usersRankDict = [String: Int]()
        var lastScore : Double? = nil
        var rank = 1
        for (userName, score) in sortedDict {
            usersRankDict[userName] = rank
            if(lastScore == nil) {
                rank += 1
            } else if(lastScore != score){
                rank += 1
            }
            lastScore = score
        }
        
        let usersRankSortedDict = usersRankDict.sorted { (lhs, rhs) -> Bool in
            return lhs.value < rhs.value
        }
        return usersRankSortedDict
    }
}
