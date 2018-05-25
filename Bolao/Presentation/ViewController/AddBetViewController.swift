//
//  AddBetViewController.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 22/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class AddBetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var teamOneScore: UITextField!
    @IBOutlet weak var teamTwoScore: UITextField!
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
    
    var match : Match?
    var users = UserPersistence.users
    var selectedUser : LocalUser? = nil
    var addBetPresenter : AddBetPresenter!
    
    @IBOutlet weak var userInfoCollectionView: UICollectionView!
    var leftFocusGuide = UIFocusGuide()
    var rightFocusGuide = UIFocusGuide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFocusGuide()
        
        teamOneLabel.text = match?.firstTeam.name
        teamTwoLabel.text = match?.secondTeam.name
        teamOneScore.placeholder = "\(match!.firstTeam.name) score"
        teamTwoScore.placeholder = "\(match!.secondTeam.name) score"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addBetPresenter = AddBetPresenter(currentMatch: match!)
        self.userInfoCollectionView.reloadData()
        users = UserPersistence.users
    }
    
    func setupFocusGuide() {
        view.addLayoutGuide(leftFocusGuide)
        self.leftFocusGuide.leadingAnchor.constraint(equalTo: self.userInfoCollectionView.leadingAnchor).isActive = true
        self.leftFocusGuide.topAnchor.constraint(equalTo: self.userInfoCollectionView.bottomAnchor).isActive = true
        self.leftFocusGuide.trailingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor).isActive = true
        self.leftFocusGuide.bottomAnchor.constraint(equalTo: self.nameTextField.topAnchor).isActive = true
        leftFocusGuide.preferredFocusedView = nameTextField
        
        view.addLayoutGuide(rightFocusGuide)
        self.rightFocusGuide.leadingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor).isActive = true
        self.rightFocusGuide.topAnchor.constraint(equalTo: self.userInfoCollectionView.bottomAnchor).isActive = true
        self.rightFocusGuide.trailingAnchor.constraint(equalTo: self.userInfoCollectionView.trailingAnchor).isActive = true
        self.rightFocusGuide.bottomAnchor.constraint(equalTo: self.nameTextField.topAnchor).isActive = true
        rightFocusGuide.preferredFocusedView = nameTextField
    }
    
    @IBAction func addBetButtonTouched(_ sender: Any) {
        var userName : String!
        var newUser : Bool
        
        if let selectedUser = self.selectedUser {
            userName = selectedUser.name
            newUser = false
        } else {
            newUser = true
            userName = nameTextField.text
        }
        
        let firstScore = teamOneScore.text ?? ""
        let secondScore = teamTwoScore.text ?? ""
        
        if userName.isEmpty ||  firstScore.isEmpty || secondScore.isEmpty {
            let alert = UIAlertController(title: "Empty Fields", message: "Fill all fields to make a bet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            addBetPresenter.newBetByUser(with: userName, newUser: newUser, firstTeamScore: Int(firstScore)!, secondTeamScore: Int(secondScore)!)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

extension AddBetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userInfocell", for: indexPath) as! UserInfoCollectionViewCell
        
        let user = users[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.infoLabel.text = "\(user.bets.count) guesses"
        
        if user.name == selectedUser?.name {
            cell.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.infoLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            cell.infoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedUser?.name == users[indexPath.row].name {
            selectedUser = nil
            nameTextField.text = ""
            nameTextField.isUserInteractionEnabled = true
            
            self.leftFocusGuide.preferredFocusedView = self.nameTextField
            self.rightFocusGuide.preferredFocusedView = self.nameTextField

        } else {
            selectedUser = users[indexPath.row]
            
            nameTextField.text = selectedUser!.name
            nameTextField.isUserInteractionEnabled = false
            
            self.leftFocusGuide.preferredFocusedView = self.teamOneScore
            self.rightFocusGuide.preferredFocusedView = self.teamTwoScore

        }
        
        collectionView.reloadData()
    }
    
    // Collection View Focus
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if collectionView == userInfoCollectionView {
            if let previousIndexPath = context.previouslyFocusedIndexPath,
                let cell = collectionView.cellForItem(at: previousIndexPath) as? UserInfoCollectionViewCell {
                cell.contentView.layer.shadowOpacity = 0
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
                if self.users[previousIndexPath.row].name == selectedUser?.name {
                    cell.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.infoLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                } else {
                    cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
                    cell.infoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                cell.transform = CGAffineTransform(scaleX: 1.0 ,y: 1.0)
            }
            
            if let indexPath = context.nextFocusedIndexPath,
                let cell = collectionView.cellForItem(at: indexPath) as? UserInfoCollectionViewCell {
                //cell.contentView.layer.shadowOpacity = 0.6
                //cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
                cell.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.infoLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.transform = CGAffineTransform(scaleX: 1.2 ,y: 1.2)
                collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
            }
        }
    }
    
}
