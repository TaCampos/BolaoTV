//
//  AddBetViewController.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 20/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class AddBetViewController: UIViewController {

    @IBOutlet weak var firstTeamScoreView: FocusableView!
    @IBOutlet weak var firstTeamScore: UILabel!

    @IBOutlet weak var secondTeamScoreView: FocusableView!
    @IBOutlet weak var secondTeamScore: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        if firstTeamScoreView.isFocused {
            print("primeira")
        } else if secondTeamScoreView.isFocused {
            print("segunda") 
        }
    }

}
