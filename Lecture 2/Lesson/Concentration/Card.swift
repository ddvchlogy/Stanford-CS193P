//
//  Card.swift
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
struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0
    
    static func getUniqueIdentifier () -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
