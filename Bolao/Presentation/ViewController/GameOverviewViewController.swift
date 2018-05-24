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
    
    @IBOutlet weak var firstTimeName: UILabel!
    @IBOutlet weak var firstTimeScore: UILabel!
    @IBOutlet weak var firstTimeView: UIView!

    @IBOutlet weak var secondTimeName: UILabel!
    @IBOutlet weak var secondTimeScore: UILabel!
    @IBOutlet weak var secondTimeView: UIView!

    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var cityName: UILabel!

    @IBOutlet weak var gameSchedule: UILabel!
    @IBOutlet weak var gameTime: UILabel!

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var betsCollectionView: UICollectionView!

    private var presenter = GameOverviewPresenter()
    private var matches: [Match]!
    private var displayingMatch: Match!
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        
        presenter.nextMatches(sorted: true) { (matches) in
            self.matches = matches
            if(matches.count > 0) {
                self.displayingMatch = matches[0]
                self.presenter.updateCurrentMatch(newValue: matches[0])
            }
        }
        
    }

    func setUpLayout() {
        self.firstTimeView.layer.cornerRadius = 25
        self.firstTimeView.clipsToBounds = true

        self.secondTimeView.layer.cornerRadius = 25
        self.secondTimeView.clipsToBounds = true

        self.addButton.layer.cornerRadius = 8
        self.addButton.clipsToBounds = true

        self.favoriteButton.layer.cornerRadius = 8
        self.favoriteButton.clipsToBounds = true
    }

    // Attributed String to header Label
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
}

extension GameOverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {


    // MARK: Games Collectio View

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        if collectionView == gamesCollectionView {
            return 8
        }
        else if collectionView == betsCollectionView {
            return 1
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == gamesCollectionView {
            return 3
        } else if collectionView == betsCollectionView {
            return 20
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gamesCollectionView{

            let cell = gamesCollectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GamesCollectionViewCell

            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true

            return cell
        }
        else if collectionView == betsCollectionView {
            let cell = betsCollectionView.dequeueReusableCell(withReuseIdentifier: "betCell", for: indexPath) as! BetsCollectionViewCell

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
                cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
                cell.transform = CGAffineTransform(scaleX: 1.0 ,y: 1.0)
            }

            if let indexPath = context.nextFocusedIndexPath,
                let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.layer.shadowOpacity = 0.6
                cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
                cell.transform = CGAffineTransform(scaleX: 1.2 ,y: 1.2)
                collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
            }
        }
    }

    // collection view header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if collectionView == gamesCollectionView {
            let header = gamesCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeaderCollectionReusableView

            let dateString = attributedStringForDate(day: "14", month: "JUN")
            header.gameDateLabel.attributedText = dateString

            return header
        }

        return UICollectionReusableView()
    }

}


