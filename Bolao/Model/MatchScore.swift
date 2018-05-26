//
//  MatchScore.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class MatchScore: Codable, DBEntity {

    private(set) var id: Int64
    private(set) var firstTeamScore: Int
    private(set) var secondTeamScore: Int
    private(set) var firstTeamPenaltiesScore: Int?
    private(set) var secondTeamPenaltiesScore: Int?
    private(set) var firstTeamScoreAuthors: [String]?
    private(set) var secondTeamScoreAuthors: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstTeamScore = "firstTeamScore"
        case secondTeamScore = "secondTeamScore"
        case firstTeamPenaltiesScore = "firstTeamPenaltiesScore"
        case secondTeamPenaltiesScore = "secondTeamPenaltiesScore"
        case firstTeamScoreAuthors = "firstTeamScoreAuthors"
        case secondTeamScoreAuthors = "secondTeamScoreAuthors"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        firstTeamScore = try values.decode(Int.self, forKey: .firstTeamScore)
        secondTeamScore = try values.decode(Int.self, forKey: .secondTeamScore)
        firstTeamPenaltiesScore = try values.decode(Int?.self, forKey: .firstTeamPenaltiesScore)
        secondTeamPenaltiesScore = try values.decode(Int?.self, forKey: .secondTeamPenaltiesScore)
        firstTeamScoreAuthors = try values.decode([String]?.self, forKey: .firstTeamScoreAuthors)
        secondTeamScoreAuthors = try values.decode([String]?.self, forKey: .secondTeamScoreAuthors)
    }
    
    init(id: Int64, firstTeamScore: Int, secondTeamScore: Int) {
        self.id = id
        self.firstTeamScore = firstTeamScore
        self.secondTeamScore = secondTeamScore
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstTeamScore, forKey: .firstTeamScore)
        try container.encode(secondTeamScore, forKey: .secondTeamScore)
        try container.encode(firstTeamPenaltiesScore, forKey: .firstTeamPenaltiesScore)
        try container.encode(secondTeamPenaltiesScore, forKey: .secondTeamPenaltiesScore)
        try container.encode(firstTeamScoreAuthors, forKey: .firstTeamScoreAuthors)
        try container.encode(secondTeamScoreAuthors, forKey: .secondTeamScoreAuthors)
        
    }
    
    // MARK: set functions
    func setId(id: Int64) {
        self.id = id
    }

    func setFirstTeamScore(firstTeamScore: Int) {
        self.firstTeamScore = firstTeamScore
    }

    func setSecondTeamScore(secondTeamScore: Int) {
        self.secondTeamScore = secondTeamScore
    }

    func setFirstTeamPenaltiesScore(firstTeamPenaltiesScore: Int?) {
        self.firstTeamPenaltiesScore = firstTeamPenaltiesScore
    }

    func setSecondTeamPenaltiesScore(secondTeamPenaltiesScore: Int?) {
        self.secondTeamPenaltiesScore = secondTeamPenaltiesScore
    }

    // MARK: add and remove functions
    func addFirstTeamScoreAuthors(newScoreAuthor: String) {
        self.firstTeamScoreAuthors?.append(newScoreAuthor)
    }

    func addSecondTeamScoreAuthors(newScoreAuthor: String) {
        self.secondTeamScoreAuthors?.append(newScoreAuthor)
    }

    // TODO: remove ScoreAuthor??


    static func urlExtention() -> String {
        return "matchScores"
    }
}

