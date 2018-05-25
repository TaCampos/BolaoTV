//
//  GameOverviewViewController.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 19/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class GameOverviewViewController: UIViewController {

    // MARK: outlets
    @IBOutlet weak var stadiumImage: UIImageView!
    
    @IBOutlet weak var firstTeamName: UILabel!
    @IBOutlet weak var firstTeamScore: UILabel!
    @IBOutlet weak var firstTeamView: UIView!

    @IBOutlet weak var secondTeamName: UILabel!
    @IBOutlet weak var secondTeamScore: UILabel!
    @IBOutlet weak var secondTeamView: UIView!

    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var cityName: UILabel!

    @IBOutlet weak var gameSchedule: UILabel!
    @IBOutlet weak var gameHour: UILabel!

    @IBOutlet weak var championshipRound: UILabel!

    @IBOutlet weak var addButton: UIButton!

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var betsCollectionView: UICollectionView!

    private var presenter = GameOverviewPresenter()
    private var matches: [Match]!
    private var displayingMatch: Match!
    private var userNamesAndBets: [String: (Int, Int)] = [:]
    private var ranking: [(String, Int)] = []

    // first day and number of games in that day
    private var gamesDay: [String] = ["14 Jun"]
    private var numberOfGamesByDay: [Int] = [0]

    // array to keep user namesBets
    private var userNamesBets:[String] = []

    // end of game
    private var hasRanking: Bool = false

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpScreenLayout()
        
        presenter.nextMatches(sorted: true) { (matches) in
            self.matches = matches
            if(matches.count > 0) {
                self.displayingMatch = matches[0]
                self.presenter.updateCurrentMatch(newValue: matches[0])
            }
        }

        // populate user and bets
        self.userNamesAndBets = presenter.usersNamesAndBets()

        // if game is over, we have a ranking.
        // vector of tubles ordered by second term - position
        if let betsRanking = presenter.allUsersRank() {
            self.hasRanking = true
            self.ranking = betsRanking.sorted(by: { $0.1 < $1.1 })
        } else {
            self.userNamesBets = Array(userNamesAndBets.keys)
        }

        // function to calculate number of games by day
        calculateNumberOfGamesByDay()
    }


    func setUpScreenLayout() {
        self.firstTeamView.layer.cornerRadius = 20
        self.firstTeamView.clipsToBounds = true

        self.secondTeamView.layer.cornerRadius = 20
        self.secondTeamView.clipsToBounds = true

        self.addButton.layer.cornerRadius = 8
        self.addButton.clipsToBounds = true

        self.betsCollectionView.layer.cornerRadius = 10
        self.betsCollectionView.clipsToBounds = true
    }


    /// Function to create attributed String to header Label
    ///
    /// - Parameters:
    ///   - day: game day
    ///   - month: game month
    /// - Returns: string formatted to have the day bigger
    func attributedStringForDate(day: String, month: String) -> NSAttributedString? {

        // day Part
        let dayTextFont = UIFont.systemFont(ofSize: 35, weight: .bold)
        let dayTextAttributes = [NSAttributedStringKey.font: dayTextFont, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedStringKey : Any]

        let dateText = NSMutableAttributedString(string: day, attributes: dayTextAttributes)

        // month Part
        let monthTextFont = UIFont.systemFont(ofSize: 23, weight: .regular)
        let monthTextAttributes = [NSAttributedStringKey.font: monthTextFont, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedStringKey : Any]

        let monthText = NSMutableAttributedString(string: "\n" + month, attributes: monthTextAttributes)

        // concatenate
        dateText.append(monthText)

        return dateText
    }


    /// Function to tranforme timeInterval into readable date
    ///
    /// - Parameter timeInterval: timeIntervalSince1970
    /// - Returns: Readable string in the format "14 Jun"
    func getDateFromTimeInterval(timeInterval: TimeInterval) -> String{
        let date = NSDate(timeIntervalSince1970: timeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"

        let stringDate = dateFormatter.string(from: date as Date)
        let dateToString = dateFormatter.date(from: stringDate)
        let dateGame = dateFormatter.string(from: dateToString!)

        return dateGame
    }


    /// Function to calculate number of games in a day
    /// get the day and see if is the same day. If it is, sum the number of games
    /// otherwise, append new day and game. This is only possible because matches
    /// is ordered by date
    func calculateNumberOfGamesByDay() {

        var i = 0
        for match in matches {

            let date = getDateFromTimeInterval(timeInterval: match.timeInterval)

            if (date == gamesDay[i]) {
                numberOfGamesByDay[i] += 1
            } else {
                i += 1
                gamesDay.append(date)
                numberOfGamesByDay.append(1)
            }
        }
    }

    func displayingMatch(matchIndex: Int) {
        self.firstTeamName.text = matches[matchIndex].firstTeam.name
        self.secondTeamName.text = matches[matchIndex].secondTeam.name

        let firstTeamScore = matches[matchIndex].score.firstTeamScore
        let secondTeamScore = matches[matchIndex].score.secondTeamScore

        self.firstTeamScore.text = String(describing: firstTeamScore)
        self.secondTeamName.text = String(describing: secondTeamScore)

        self.stadiumName.text = matches[matchIndex].stadium
        self.cityName.text = matches[matchIndex].city

        self.championshipRound.text = matches[matchIndex].championshipRound

        // date formatter
        let date = NSDate(timeIntervalSince1970: matches[matchIndex].timeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        dateFormatter.dateFormat = "EEEE, MMMM dd"
        let stringDate = dateFormatter.string(from: date as Date)
        let dateToString = dateFormatter.date(from: stringDate)
        let gameSchedule = dateFormatter.string(from: dateToString!)

        self.gameSchedule.text = gameSchedule

        // hour formatter
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)

        self.gameHour.text = "\(String(describing: hour)):\(String(describing: minutes))"
    }
}

extension GameOverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        if collectionView == gamesCollectionView {
            return gamesDay.count
        }
        else if collectionView == betsCollectionView {
            return 1
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == gamesCollectionView {
            return numberOfGamesByDay[section]
        } else if collectionView == betsCollectionView {
            return userNamesAndBets.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gamesCollectionView{

            let cell = gamesCollectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GamesCollectionViewCell

            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true

            // get first and second team for the macth
            let firstTeam = matches[indexPath.row].firstTeam
            let secondTeam = matches[indexPath.row].secondTeam

            // get flags image names
            let firstTeamImage = firstTeam.name + "First"
            let secondTeamImage = firstTeam.name + "Second"


            cell.teamOneImage.image = UIImage(named: firstTeamImage)
            cell.teamTwoImage.image = UIImage(named: secondTeamImage)

            cell.nameTeamOne.text = firstTeam.name
            cell.nameTeamTwo.text = secondTeam.name

            return cell
        }
        else if collectionView == betsCollectionView {
            let cell = betsCollectionView.dequeueReusableCell(withReuseIdentifier: "betCell", for: indexPath) as! BetsCollectionViewCell

            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true

            var username = ""

            // if there is a ranking, show by classification
            // otherwise, show bets by user until the moment

            if hasRanking {
                username = ranking[indexPath.row].0

                switch ranking[indexPath.row].1 {
                case 1:
                    cell.personNameBet.text = "🥇 \(username)"
                    cell.bubbleImage.image = UIImage(named: "bubbleGold")
                case 2:
                    cell.personNameBet.text = "🥈 \(username)"
                    cell.bubbleImage.image = UIImage(named: "bubbleSilver")
                case 3:
                    cell.personNameBet.text = "🥉 \(username)"
                    cell.bubbleImage.image = UIImage(named: "bubbleBronze")
                default:
                     cell.personNameBet.text = "\(String(describing: ranking[indexPath.row].1))º \(username)"
                    cell.bubbleImage.image = UIImage(named: "bubble")
                }
            } else {
                username = userNamesBets[indexPath.row]
                cell.personNameBet.text = username
            }

            if let betScore = userNamesAndBets[username] {
                cell.scoreBet.text = "\(betScore.0) - \(betScore.1)"
            } else {
                cell.scoreBet.text = "  -  "
            }

            return cell
        }

        return UICollectionViewCell()
    }

    // Collection View Focus
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        if collectionView == gamesCollectionView {
            if let previousIndexPath = context.previouslyFocusedIndexPath,
                let cell = collectionView.cellForItem(at: previousIndexPath) {
                cell.contentView.layer.shadowOpacity = 0
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
                cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
                cell.transform = CGAffineTransform(scaleX: 1.0 ,y: 1.0)
            }

            if let indexPath = context.nextFocusedIndexPath,
                let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.layer.shadowOpacity = 0.6
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
                cell.backgroundColor =  #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
                cell.transform = CGAffineTransform(scaleX: 1.2 ,y: 1.2)
                collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
            }
        }

        if collectionView == betsCollectionView {
            if let previousIndexPath = context.previouslyFocusedIndexPath,
                let cell = collectionView.cellForItem(at: previousIndexPath) {
                cell.contentView.layer.shadowOpacity = 0
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
                cell.backgroundColor = .clear
                cell.transform = CGAffineTransform(scaleX: 1.0 ,y: 1.0)
            }

            if let indexPath = context.nextFocusedIndexPath,
                let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.layer.shadowOpacity = 0.6
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
                cell.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.6)
                cell.transform = CGAffineTransform(scaleX: 1.1 ,y: 1.1)
                collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
            }
        }
    }

    // collection view header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if collectionView == gamesCollectionView {
            let header = gamesCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeaderCollectionReusableView

            // get title header - split the date to customize
            let date = gamesDay[indexPath.section]
            let dateArray = date.components(separatedBy: " ")

            let dateString = attributedStringForDate(day: dateArray[0], month: dateArray[1])
            header.gameDateLabel.attributedText = dateString

            return header
        }

        return UICollectionReusableView()
    }

    // display choosed macth
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == gamesCollectionView {
            self.displayingMatch = matches[indexPath.row]
            self.displayingMatch(matchIndex: indexPath.row)

            presenter.updateCurrentMatch(newValue: displayingMatch)
        }
    }
}


