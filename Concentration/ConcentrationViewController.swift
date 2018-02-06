//
//  ViewController.swift
//  Concentration
//
//  Created by Ivan Tchernev on 10/01/2018.
//  Copyright © 2018 AND Digital. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    var theme: GameTheme! {
        didSet {
            implementTheme()
        }
    }
    
    func chooseRandomGameTheme() {
        let randomGameThemeInt = GameTheme.count.arc4random
        theme = GameTheme(rawValue: randomGameThemeInt) ?? GameTheme.Halloween
    }
    
    private func implementTheme() {
        self.view.backgroundColor = theme.secondaryColor
        scoreLabel.textColor = theme.primaryColor
        gameCompleteLabel.textColor = theme.primaryColor
        newGameButton.backgroundColor = theme.primaryColor
        newGameButton.setTitleColor(theme.secondaryColor, for: UIControlState.normal)
        emoji = [:]
        unusedEmojis = theme.emojiChoices
        updateViewFromModel()
    }
    
    private lazy var game = Concentration(numberOfCards: cardButtons.count)
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton)
    {
        if let index = cardButtons.index(of: sender) {
            game.chooseCard(at: index)
            updateViewFromModel()
        } else {
            print("This card is not part of the cards array")
        }
    }
    
    @IBOutlet private weak var gameCompleteLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        if game.isGameComplete {
            chooseRandomGameTheme()
            game = Concentration(numberOfCards: cardButtons.count)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel()
    {
        let scoreAttributes: [NSAttributedStringKey: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : theme.primaryColor
        ]
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: scoreAttributes)
        scoreLabel.attributedText = attributedString
        
        if game.isGameComplete {
            gameCompleteLabel.text = "Well done! Care to try again?"
            newGameButton.backgroundColor = theme.primaryColor
            newGameButton.setTitle("New Game", for: UIControlState.normal)
        } else {
            gameCompleteLabel.text = ""
            newGameButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            newGameButton.setTitle("", for: UIControlState.normal)
        }
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControlState.normal)
            } else if card.isMatched {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                button.setTitle("", for: UIControlState.normal)
            } else {
                button.backgroundColor = theme.primaryColor
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    //Code for selection of the emojis to appear on cards
    private var emoji = [Card:String]()
    private var unusedEmojis: String!
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil {
            let randomStringIndex = unusedEmojis.index(unusedEmojis.startIndex, offsetBy: unusedEmojis.count.arc4random)
            emoji[card] = String(unusedEmojis.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

