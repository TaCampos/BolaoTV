//
//  Team.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Team: NSObject {
    private(set) var id: Int64
    private(set) var name: String

    // MARK: Relationship
    private(set) var matches: [Match]?

    init(id: Int64, name: String) {
        self.id = id
        self.name = name
    }

    // MARK: set functions
    func setId(id: Int64) {
        self.id = id
    }

    func setName(name: String) {
        self.name = name
    }

    // MARK: add and remove functions

    func addMatch(match: Match) {
        self.matches?.append(match)
    }

    func removeMatch(atIndex index: Int) -> Match {
        return (matches?.remove(at: index))!
    }
}

