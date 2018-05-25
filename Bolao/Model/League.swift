//
//  League.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class League: Codable, DBEntity {

    private(set) var id: Int64
    private(set) var name: String

    // MARK: Relationship
    private(set) var championship: Championship
    private(set) var scoreRules: ScoreRules
    private(set) var admin: User
    private(set) var users: [User]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case championship = "championship"
        case scoreRules = "scoreRules"
        case admin = "admin"
        case users = "users"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int64.self, forKey: .id)
        championship = try values.decode(Championship.self, forKey: .championship)
        scoreRules = try values.decode(ScoreRules.self, forKey: .scoreRules)
        admin = try values.decode(User.self, forKey: .admin)
        users = try values.decode([User].self, forKey: .users)
        
    }
    
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
    
    static func urlExtention() -> String {
        return "leagues"
    }
}

