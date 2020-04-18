//
//  ViewController.swift
//  Concentration
//
//  Created by Dazz Woo on 2020/4/17.
//  Copyright © 2020 Dazz Woo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    lazy var randomTheme = initThemes()
    var emoji = [Int: String]()
    
    @IBOutlet weak var filpCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
//            //TODO
//            if !game.cards[cardNumber].isFaceUp, !game.cards[cardNumber].isMatched {
//                game.flipCount += 1
//            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        game.flipCount = 0
        game.score = 0
        randomTheme = initThemes()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        updateFlipCount()
        updateScore()
    }
    
    func updateFlipCount() {
        filpCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(game.score)"
    }
 
    func initThemes() -> [String] {
        let themes = [
            ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🤡", "🧟‍♂️", "👺"], //Halloween theme
            ["🐭", "🐮", "🐯", "🐰", "🐲", "🐍", "🐴", "🐑", "🐵", "🐔", "🐶", "🐷"], //Chinese zodiac theme
            ["🍙", "🍜", "🍣", "🥮", "🍡", "🌮", "🍟", "🍔", "🍗", "🥓", "🧀", "🥪"], //Food theme
            ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓", "🏑", "🥍"], //Sports theme
            ["📱", "⌚️", "⌨️", "🖱", "🖥", "📷", "🕹", "🎮", "🎧", "📀", "🎥", "💾"], //Digital product theme
            ["🇮🇳", "🇭🇰", "🇮🇩", "🇲🇾", "🇲🇳", "🇧🇩", "🇻🇳", "🇳🇵", "🇯🇵", "🇨🇳", "🇹🇷", "🇹🇼"]  //Asia flag theme
        ]
        return themes[Int(arc4random_uniform(UInt32(themes.count)))]
    }
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, randomTheme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(randomTheme.count)))
            emoji[card.identifier] = randomTheme.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

}

