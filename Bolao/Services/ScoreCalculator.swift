//
//  ScoreCalculator.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class ScoreCalculator {
    static func score(of user: LocalUser, in: Match) -> Double? {
        return 0
    }

    static func score(of users: [LocalUser], in: Match) -> [(LocalUser, Double?)] {
        return []
    }
    
    static func score(of users: [LocalUser], in: [Match]) -> [(LocalUser, Double?)] {
        return []
    }
}
