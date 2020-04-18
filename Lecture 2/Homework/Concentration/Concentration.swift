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
    var score = 0
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched { //所选卡片未消失
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index { //所点的是第二张卡片
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier { //如果配对成功
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else { //如果配对失败
                    if cards[index].beenFilped {
                        score -= 1
                    }
                    if cards[matchIndex].beenFilped {
                        score -= 1
                    }
                    cards[matchIndex].beenFilped = true
                    cards[index].beenFilped = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else { //所点的是第一张卡片
                //either no card, or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        cards.shuffle()
    }
    
}
