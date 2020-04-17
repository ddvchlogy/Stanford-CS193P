//
//  ViewController.swift
//  Concentration
//
//  Created by Dazz Woo on 2020/4/17.
//  Copyright © 2020 Dazz Woo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0 {
        didSet { //属性监视器，监测到 filpCount 变化后执行
            filpCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var filpCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃", "🐢", "🎃", "🐢"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withemoji: emojiChoices[cardNumber], on: sender)

        } else {
            print("not")
        }
    }
    
    func flipCard(withemoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    

}

