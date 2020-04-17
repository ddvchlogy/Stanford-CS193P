//
//  Concentration.swift
//  Concentration
//
//  Created by Dazz Woo on 2020/4/17.
//  Copyright © 2020 Dazz Woo. All rights reserved.
//

import Foundation

//  结构体和类的区别
//  1.结构体无继承
//  2.结构体是值类型，类是引用类型
//   值类型在传递时复制，引用类型传递时传递指针
class Concentration {
    
    var cards = [Card]() // 空列表，列表对象为Card()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no card, or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
    }
    
}
