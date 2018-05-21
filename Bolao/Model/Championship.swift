//
//  Championship.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Championship: NSObject {

    private(set) var id: Int64
    private(set) var name: String
    private(set) var season: String

    // MARK: Relationship
    private(set) var teams: [Team]
    private(set) var matches: [Match]

    init(id: Int64, name: String, season: String, teams: [Team], matches: [Match]) {
        self.id = id
        self.name = name
        self.season = season
        self.teams = teams
        self.matches = matches
    }

    // MARK: set functions

    func setId(id: Int64) {
        self.id = id
    }

    func setChampionshipName(name: String) {
        self.name = name
    }

    func setSeason(season: String) {
        self.season = season
    }

    // MARK: add and remove elements

    func addTeams(newTeam: Team) {
        teams.append(newTeam)
    }

    func removeTeam(atIndex index: Int) -> Team {
        return teams.remove(at: index)
    }

    func addMatch(newMatch: Match) {
        matches.append(newMatch)
    }

    func removeMatch(atIndex index: Int) -> Match {
        return matches.remove(at: index)
    }



}

