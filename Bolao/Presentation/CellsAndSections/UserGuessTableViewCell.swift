//
//  UserGuessTableViewCell.swift
//  Bolao
//
//  Created by Rafael Zane on 24/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class UserGuessTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeam: UILabel!

    @IBOutlet weak var visitorTeam: UILabel!
    
    @IBOutlet weak var homeScore: UILabel!

    @IBOutlet weak var homeLayer: UIView!
    
    @IBOutlet weak var visitorLayer: UIView!
    @IBOutlet weak var visitorScore: UILabel!
    @IBOutlet weak var scoreSeparator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        homeLayer.layer.cornerRadius = 8
        homeLayer.layer.masksToBounds = true
        visitorLayer.layer.cornerRadius = 8
        visitorLayer.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
