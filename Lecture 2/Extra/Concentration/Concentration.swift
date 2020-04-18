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
                    //以时间评估得分
                    score += evaluateScore(cards[matchIndex].lastSeen, Date(), prizeOrNot: true)
                } else { //如果配对失败
                    cards[index].lastSeen = Date() //获取点击当前第二张卡片时间
                    if cards[index].beenFilped { //对已翻过卡片 以时间评估罚分
                        score += evaluateScore(cards[matchIndex].lastSeen, cards[index].lastSeen, prizeOrNot: false)
                    }
                    if cards[matchIndex].beenFilped { //对已翻过卡片 以时间评估罚分 此处对两张都翻过的卡片双倍罚分
                        score += evaluateScore(cards[matchIndex].lastSeen, cards[index].lastSeen, prizeOrNot: false)
                    }
                    //配对失败标记已翻过
                    cards[index].beenFilped = true
                    cards[matchIndex].beenFilped = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else { //所点的是第一张卡片
                //either no card, or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                cards[index].lastSeen = Date()
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    func evaluateScore(_ cardA: Date, _ cardB: Date, prizeOrNot: Bool) -> Int { //时间评估得、罚分，罚分只针对翻已翻过一次的卡片
        if cardA + 1.0 > cardB { //点击第一张卡片1秒之内
            if prizeOrNot { //得5分
                return 5
            } else { //罚3分
                return -3
            }
        } else if cardA + 5.0 > cardB { //点击第一张卡片5秒之内
            if prizeOrNot { //得4分
                return 4
            } else { //罚2分
                return -2
            }
        } else { //点击第一张卡片5秒之外
            if prizeOrNot { //得3分
                return 3
            } else { //罚1分
                return -1
            }
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
