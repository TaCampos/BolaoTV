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
        _users = defaults.object(forKey: userDefaultsKey) as? [LocalUser] ?? [LocalUser]()
    }
    
    static func updateUsers(_ newValue : [LocalUser]) {
        _users = newValue
        let defaults = UserDefaults.standard
        //defaults.set(_users, forKey: userDefaultsKey)
    }
}
