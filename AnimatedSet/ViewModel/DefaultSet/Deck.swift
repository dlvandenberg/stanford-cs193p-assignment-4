//
//  Deck.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import Foundation

struct Deck: SetDeck {
    var cards: Set<Card>
    
    init() {
        cards = Set(Deck.generateCards())
    }
}
