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
    
    var selectedUser: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            return 2
        case guessesTableView:
            if(selectedUser != nil) {
                if(selectedUser == 0) {
                    return 3
                } else {
                    return 10
                }
            }
            return 0
            
        case resultsTableView:
            if(selectedUser != nil) {
                if(selectedUser == 0) {
                    return 3
                } else {
                    return 10
                }
            }
            return 0
        case pointsTableView:
            if(selectedUser != nil) {
                if(selectedUser == 0) {
                    return 3
                } else {
                    return 10
                }
            }
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case classificationTableView:
            let cell = classificationTableView.dequeueReusableCell(withIdentifier: "UserRankCell", for: indexPath) as! UserRankTableViewCell
            
            return cell
        case guessesTableView:
            let cell = guessesTableView.dequeueReusableCell(withIdentifier: "UserGuessCell", for: indexPath) as! UserGuessTableViewCell
            
            cell.homeScore.text = String(indexPath.row)
            cell.visitorScore.text = String(indexPath.row)
            
            return cell
        case resultsTableView:
            let cell = resultsTableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultsTableViewCell
            
            cell.homeScore.text = String(indexPath.row)
            cell.visitorScore.text = String(indexPath.row)
            
            return cell
        case pointsTableView:
            let cell = pointsTableView.dequeueReusableCell(withIdentifier: "UserPointsCell", for: indexPath) as! UserPointsCell
            cell.pointsLabel.text = String(indexPath.row)
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
                cell.backgroundColor = #colorLiteral(red: 0.869321066, green: 0.869321066, blue: 0.869321066, alpha: 1)
                cell.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.gamesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.gamesWord.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.positionLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                cell.pointsLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                cell.pointsWord.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                cell.transform = CGAffineTransform(scaleX: 1.1 ,y: 1.1)
                cell.focusStyle = .custom
                tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
                selectedUser = indexPath.row
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
                
            }
            
            if let indexPath = context.nextFocusedIndexPath,
                let cell = tableView.cellForRow(at: indexPath) as? UserGuessTableViewCell {
                cell.backgroundColor = #colorLiteral(red: 0.869321066, green: 0.869321066, blue: 0.869321066, alpha: 1)
                cell.homeScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.visitorScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.visitorLayer.backgroundColor = .clear
                cell.homeLayer.backgroundColor = .clear
                cell.homeTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.visitorTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.scoreSeparator.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.focusStyle = .custom
                
                if let resultCell = resultsTableView.cellForRow(at: indexPath) as? ResultsTableViewCell {
                    resultCell.backgroundColor = #colorLiteral(red: 0.869321066, green: 0.869321066, blue: 0.869321066, alpha: 1)
                    resultCell.homeScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.visitorScore.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.visitorLayer.backgroundColor = .clear
                    resultCell.homeLayer.backgroundColor = .clear
                    resultCell.homeTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.visitorTeam.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.scoreSeparator.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    resultCell.focusStyle = .custom
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
