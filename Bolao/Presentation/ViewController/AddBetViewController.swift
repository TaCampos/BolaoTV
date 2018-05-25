//
//  AddBetViewController.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 22/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit
import TvOSScribble

class AddBetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var teamOneScore: UITextField!
    @IBOutlet weak var teamTwoScore: UITextField!
    
    var users = UserPersistence.users
    
    var selectedUser : LocalUser? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = TvOSScribbleGestureRecognizer(target: self, action: #selector(AddBetViewController.gestureDidRecognizer))
        
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gestureDidRecognizer(recognizer: TvOSScribbleGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        
    }
    
    @IBAction func addBetButtonTouched(_ sender: Any) {
        
        if let selectedUser = self.selectedUser {
            // TODO: add bet to selected user
        } else {
            // TODO: create new user and add bet
        }
        
        self.dismiss(animated: true, completion: nil)
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedUser?.name == users[indexPath.row].name {
            selectedUser = nil
            nameTextField.text = ""
            nameTextField.isUserInteractionEnabled = true
        } else {
            selectedUser = users[indexPath.row]
            
            nameTextField.text = selectedUser!.name
            nameTextField.isUserInteractionEnabled = false
        }
    }
}
