//
//  ViewController.swift
//  PlayingCard
//
//  Created by Dazz Woo on 2020/5/2.
//  Copyright © 2020 Dazz Woo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var deck = PlayingCardDeck()
        
        for _ in 1...10 {
            if let card = deck.draw() {
                print ("\(card)")
            }
        }
        // Do any additional setup after loading the view.
    }


}

