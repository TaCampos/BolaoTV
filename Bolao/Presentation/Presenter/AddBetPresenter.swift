//
//  AddBetPresenter.swift
//  Bolao
//
//  Created by Alexandre Conti Mestre on 25/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class AddBetPresenter {
    
    private var currentMatch: Match? = nil
    
    private var users: [LocalUser]?
    
    init(currentMatch: Match) {
        self.users = UserPersistence.users
        self.currentMatch = currentMatch
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
}
