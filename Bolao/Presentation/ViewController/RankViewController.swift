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
            return 2
        case resultsTableView:
            return 2
        case pointsTableView:
            return 2
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
            
            return cell
        case resultsTableView:
            let cell = resultsTableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultsTableViewCell
            
            return cell
        case pointsTableView:
            let cell = pointsTableView.dequeueReusableCell(withIdentifier: "UserPointsCell", for: indexPath) as! UserPointsCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        if(tableView == classificationTableView) {
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
            }
            
            if let indexPath = context.nextFocusedIndexPath,
                let cell = tableView.cellForRow(at: indexPath) as? UserRankTableViewCell {
                cell.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.6)
                cell.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.gamesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.gamesWord.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.transform = CGAffineTransform(scaleX: 1.1 ,y: 1.1)
                tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
                
                
            }
        }
    }
}
