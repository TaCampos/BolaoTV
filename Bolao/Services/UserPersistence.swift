//
//  UserPersistence.swift
//  Bolao
//
//  Created by Rafael Zane on 23/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import Foundation

class UserPersistence {
    
    static private var userDefaultsKey = "usersArray"
    static private var _users: [LocalUser]? = nil
    
    static var users: [LocalUser] {
        get {
            if(_users == nil) {
                loadUsers()
            }
            return [LocalUser](_users!)
        }
        set {
            updateUsers(newValue)
        }
    }
    
    static private func loadUsers() {
        let defaults = UserDefaults.standard
        let dataToLoad = defaults.object(forKey: userDefaultsKey) as? Data
        if(dataToLoad != nil) {
            let jsonDecoder = JSONDecoder()
            let jsonData = try? jsonDecoder.decode(Data.self, from: dataToLoad!)
            _users = try? jsonDecoder.decode([LocalUser].self, from: jsonData!)
        } else {
            _users = [LocalUser]()
        }
        
    }
    
    static func updateUsers(_ newValue : [LocalUser]) {
        _users = newValue
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(_users)
        let dataToSave = try? jsonEncoder.encode(jsonData)
        
        defaults.set(dataToSave, forKey: userDefaultsKey)
    }
}
