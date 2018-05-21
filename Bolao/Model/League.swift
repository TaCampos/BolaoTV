//
//  League.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class League: NSObject {

    private(set) var id: Int64
    private(set) var name: String

    // MARK: Relationship
    private(set) var championship: Championship
    private(set) var scoreRules: ScoreRules
    private(set) var admin: User
    private(set) var users: [User]

    init(id: Int64, name: String, championship: Championship, scoreRules: ScoreRules, admin: User, users: [User]) {
        self.id = id
        self.name = name
        self.championship = championship
        self.scoreRules = scoreRules
        self.admin = admin
        self.users = users
    }

    // MARK: set functions

    func setId(id: Int64) {
        self.id = id
    }

    func setLeagueName(name: String) {
        self.name = name
    }

    func setChampionship(championship: Championship) {
        self.championship = championship
    }

    func setScoreRules(scoreRules: ScoreRules) {
        self.scoreRules = scoreRules
    }

    func setUserAdmin(admin: User) {
        self.admin = admin
    }

    // MARK: add and remove users function

    // add and remove users
    func addUser(newUser: User) {
        users.append(newUser)
    }

    func removeUser(atIndex index: Int) -> User {
        return users.remove(at: index)
    }
}

