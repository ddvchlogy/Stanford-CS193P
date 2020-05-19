//
//  ViewController.swift
//  Concentration
//
//  Created by Dazz Woo on 2020/4/17.
//  Copyright © 2020 Dazz Woo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    lazy var randomTheme = initThemes()
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    var emoji = [Int: String]()
    
    @IBOutlet private weak var filpCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
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
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
 
    private func initThemes() -> [String] {
        let themes = [
            ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🤡", "🧟‍♂️", "👺"], //Halloween theme
            ["🐭", "🐮", "🐯", "🐰", "🐲", "🐍", "🐴", "🐑", "🐵", "🐔", "🐶", "🐷"], //Chinese zodiac theme
            ["🍙", "🍜", "🍣", "🥮", "🍡", "🌮", "🍟", "🍔", "🍗", "🥓", "🧀", "🥪"], //Food theme
            ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓", "🏑", "🥍"], //Sports theme
            ["📱", "⌚️", "⌨️", "🖱", "🖥", "📷", "🕹", "🎮", "🎧", "📀", "🎥", "💾"], //Digital products theme
            ["🇮🇳", "🇭🇰", "🇮🇩", "🇲🇾", "🇲🇳", "🇧🇩", "🇻🇳", "🇳🇵", "🇯🇵", "🇨🇳", "🇹🇷", "🇸🇬"]  //Asia flags theme
        ]
        
        return themes[Int(arc4random_uniform(UInt32(themes.count)))]
    }
    
    private func emoji(for card: Card) -> String {
        
        
        if emoji[card.identifier] == nil, randomTheme.count > 0 {
            emoji[card.identifier] = randomTheme.remove(at: randomTheme.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
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
