//
//  User.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class User: NSObject {

    private(set) var id: Int64
    private(set) var name: String
    private(set) var email: String
    private(set) var photoURL: URL?
    private var updateImage = false

    // MARK: Relationship
    private(set) var bets: [Bet]
    private(set) var leagues: [League]
    private(set) var teams: [Team]?

    init(id: Int64, name: String, email: String, bets: [Bet], leagues: [League], teams: [Team]) {
        self.id = id
        self.name = name
        self.email = email
        self.bets = bets
        self.leagues = leagues
        self.teams = teams
    }

    // MARK: functions
    
    func setId(id: Int64) {
        self.id = id
    }


    // add and remove bets
    func addBet(newBet: Bet) {
        bets.append(newBet)
    }

    func removeBet(atIndex index: Int) -> Bet {
        return bets.remove(at: index)
    }

    // add and remove leagues
    func addLeague(newLeague: League) {
        leagues.append(newLeague)
    }

    func removeLeague(atIndex index: Int) -> League {
        return leagues.remove(at: index)
    }

    // add and remove teams
    func addTeam(newTeam: Team) {
        teams?.append(newTeam)
    }

    func removeTeam(atIndex index: Int) -> Team {
        return (teams?.remove(at: index))!
    }

    // MARK:- methods related to the user image

    /// Sets the url to download the image from the database
    ///
    /// - Parameter url: url to download the image
    func setImageURL(url: URL) {
        self.photoURL = url
        self.updateImage = false
    }

    /// method to download the image from the database
    ///
    /// - Parameter completion: Completion with the doctor image
    func downloadImageURL(_ completion: ((_ photoURL: URL?) -> Void)?) {

        // TODO - get from server
    }

    /// Returns the profile image if already downloaded
    ///
    /// - Returns: profile image url
    func getDownloadedImage() -> URL? {
        return self.photoURL
    }

    /// Informs if the user image shoul be updated in the database
    ///
    /// - Returns: bool indicating if should update the image
    func shouldUpdateImage() -> Bool {
        return updateImage
    }





















}
