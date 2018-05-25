//
//  RankViewController.swift
//  Bolao
//
//  Created by Rafael Zane on 24/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {

    @IBOutlet weak var classificationTableView: UITableView!
    @IBOutlet weak var guessesTableView: UITableView!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var pointsTableView: UITableView!
    
    var usersHistoricAndRank: ([((key: String, value: ([(MatchScore, MatchScore?)], Double)), Int)])? = nil
    var currentUserBetsAndResults: [(MatchScore, MatchScore?)]? = nil
    var currentUserScores: [Double?]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RankViewPresenter.allUsersHistoricAndRank { (usersHistoricAndRank) in
            self.usersHistoricAndRank = usersHistoricAndRank
        }
        setUpTableViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTableViews() {
        classificationTableView.delegate = self
        classificationTableView.dataSource = self
        guessesTableView.delegate = self
        guessesTableView.layer.cornerRadius = 15
        guessesTableView.layer.masksToBounds = true
        guessesTableView.dataSource = self
        resultsTableView.delegate = self
        resultsTableView.layer.cornerRadius = 15
        resultsTableView.layer.masksToBounds = true
        resultsTableView.dataSource = self
        pointsTableView.delegate = self
        pointsTableView.layer.cornerRadius = 15
        pointsTableView.layer.masksToBounds = true
        pointsTableView.dataSource = self
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RankViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case classificationTableView:
            return usersHistoricAndRank?.count ?? 0
        case guessesTableView:
            return currentUserBetsAndResults?.count ?? 0
        case resultsTableView:
            return currentUserBetsAndResults?.count ?? 0
        case pointsTableView:
            return currentUserBetsAndResults?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case classificationTableView:
            let cell = classificationTableView.dequeueReusableCell(withIdentifier: "UserRankCell", for: indexPath) as! UserRankTableViewCell
            
            let user = usersHistoricAndRank![indexPath.row].0
            let rank = usersHistoricAndRank![indexPath.row].1
            currentUserBetsAndResults = user.value.0
            currentUserScores = RankViewPresenter.scoreOfUserInEachMatch(betsAndResults: user.value.0)
            cell.nameLabel.text = user.key
            cell.positionLabel.text = String(rank)
            cell.positionLabel.text = String(user.value.1)
            
            return cell
        case guessesTableView:
            let cell = guessesTableView.dequeueReusableCell(withIdentifier: "UserGuessCell", for: indexPath) as! UserGuessTableViewCell
            
            cell.homeScore.text = String(currentUserBetsAndResults![indexPath.row].0.firstTeamScore)
            cell.visitorScore.text = String(currentUserBetsAndResults![indexPath.row].0.secondTeamScore)
            return cell
            
        case resultsTableView:
            let cell = resultsTableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultsTableViewCell
            
            if let results = currentUserBetsAndResults![indexPath.row].1 {
                cell.homeScore.text = String(results.firstTeamScore)
                cell.visitorScore.text = String(results.secondTeamScore)
            } else {
                cell.homeScore.text = ""
                cell.visitorScore.text = ""
            }
            
            return cell
            
        case pointsTableView:
            let cell = pointsTableView.dequeueReusableCell(withIdentifier: "UserPointsCell", for: indexPath) as! UserPointsCell
            if let matchScore = currentUserScores?[indexPath.row] {
                cell.pointsLabel.text = String(matchScore)
            } else {
                cell.pointsLabel.text = "-"
            }
            
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        if(tableView == classificationTableView || tableView == guessesTableView) {
            return true
        } else {
            return false
        }
    }
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        

        if(tableView == classificationTableView) {
            if let previousIndexPath = context.previouslyFocusedIndexPath,
                let cell = tableView.cellForRow(at: previousIndexPath) as? UserRankTableViewCell{
                cell.contentView.layer.shadowOpacity = 0
                cell.backgroundColor = .clear
                cell.transform = CGAffineTransform(scaleX: 1.0 ,y: 1.0)
                cell.nameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.gamesLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.gamesWord.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.positionLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                cell.pointsLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                cell.pointsWord.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                cell.focusStyle = .custom
            }
            
            if let indexPath = context.nextFocusedIndexPath,
                let cell = tableView.cellForRow(at: indexPath) as? UserRankTableViewCell {
                cell.backgroundColor = #colorLiteral(red: 0.869321066, green: 0.869321066, blue: 0.869321066, alpha: 0.7)
                cell.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.gamesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.gamesWord.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.positionLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                cell.pointsLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                cell.pointsWord.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                cell.transform = CGAffineTransform(scaleX: 1.1 ,y: 1.1)
                cell.focusStyle = .custom
                tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
                guessesTableView.reloadData()
                resultsTableView.reloadData()
                pointsTableView.reloadData()
            }
        } else if(tableView == guessesTableView) {
            if let previousIndexPath = context.previouslyFocusedIndexPath,
                let cell = tableView.cellForRow(at: previousIndexPath) as? UserGuessTableViewCell{
                cell.contentView.layer.shadowOpacity = 0
                cell.backgroundColor = .clear
                cell.transform = CGAffineTransform(scaleX: 1.0 ,y: 1.0)
                cell.homeScore.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.visitorScore.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.visitorLayer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
                cell.homeLayer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
                cell.homeTeam.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.visitorTeam.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.scoreSeparator.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.focusStyle = .custom
                
                if let resultCell = resultsTableView.cellForRow(at: previousIndexPath) as? ResultsTableViewCell {
                    resultCell.contentView.layer.shadowOpacity = 0
                    resultCell.backgroundColor = .clear
                    resultCell.homeScore.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    resultCell.visitorScore.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    resultCell.visitorLayer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
                    resultCell.homeLayer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
                    resultCell.homeTeam.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    resultCell.visitorTeam.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    resultCell.scoreSeparator.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    resultCell.focusStyle = .custom
                }

                if let pointsCell = pointsTableView.cellForRow(at: previousIndexPath) as? UserPointsCell {
                    pointsCell.contentView.layer.shadowOpacity = 0
                    pointsCell.backgroundColor = .clear
                    pointsCell.pointsLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    pointsCell.ptsLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    pointsCell.focusStyle = .custom
                }
            }
            if let indexPath = context.nextFocusedIndexPath,
                let cell = tableView.cellForRow(at: indexPath) as? UserGuessTableViewCell {
                cell.backgroundColor = #colorLiteral(red: 0.869321066, green: 0.869321066, blue: 0.869321066, alpha: 0.7)
                cell.homeScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.visitorScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.visitorLayer.backgroundColor = .clear
                cell.homeLayer.backgroundColor = .clear
                cell.homeTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.visitorTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.scoreSeparator.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.focusStyle = .custom
                
                if let resultCell = resultsTableView.cellForRow(at: indexPath) as? ResultsTableViewCell {
                    resultCell.backgroundColor = #colorLiteral(red: 0.869321066, green: 0.869321066, blue: 0.869321066, alpha: 0.7)
                    resultCell.homeScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.visitorScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.visitorLayer.backgroundColor = .clear
                    resultCell.homeLayer.backgroundColor = .clear
                    resultCell.homeTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.visitorTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.scoreSeparator.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.focusStyle = .custom
                }

                if let pointsCell = pointsTableView.cellForRow(at: indexPath) as? UserPointsCell {
                    pointsCell.contentView.layer.shadowOpacity = 0
                    pointsCell.backgroundColor = #colorLiteral(red: 0.869321066, green: 0.869321066, blue: 0.869321066, alpha: 0.7)
                    pointsCell.pointsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    pointsCell.ptsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    pointsCell.focusStyle = .custom
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == guessesTableView) {
            resultsTableView.contentOffset = scrollView.contentOffset
            pointsTableView.contentOffset = scrollView.contentOffset
        }
    }

}
