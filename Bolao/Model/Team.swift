//
//  Team.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class Team: Codable, DBEntity {
    private(set) var id: Int64
    private(set) var name: String

    // MARK: Relationship
    //private(set) var matches: [Match]?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        //case matches = "matches"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int64.self, forKey: .id)
        //matches = try values.decode([Match]?.self, forKey: .matches)
    }
    
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
    
    static func urlExtention() -> String {
        return "teams"
    }
}

