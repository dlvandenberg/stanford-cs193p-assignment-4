//
//  SetSelection.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import Foundation

struct SetSelection<Card: SetCard> {
    // MARK: Properties
    private var firstCard: Card
    private var secondCard: Card
    private var thirdCard: Card
    
    var cards: [Card] { [firstCard, secondCard, thirdCard] }
    let isValidSet: Bool
    
    // MARK: Failable initializer
    init?(firstCard: Card, secondCard: Card, thirdCard: Card) {
        let cards = Set([firstCard, secondCard, thirdCard])
        guard cards.count == Constants.SELECTION_COUNT else {
            return nil
        }
        
        self.firstCard = firstCard
        self.secondCard = secondCard
        self.thirdCard = thirdCard
        self.isValidSet = SetSelection.isSelectionASet(firstCard: firstCard, secondCard: secondCard, thirdCard: thirdCard)
    }
}

// MARK: Matching
extension SetSelection {
    private static func isSelectionASet(firstCard: Card, secondCard: Card, thirdCard: Card) -> Bool {
        (
            (firstCard.feature1 == secondCard.feature1 && secondCard.feature1 == thirdCard.feature1) ||
            (firstCard.feature1 != secondCard.feature1 && secondCard.feature1 != thirdCard.feature1 && firstCard.feature1 != thirdCard.feature1)
        ) &&
        (
            (firstCard.feature2 == secondCard.feature2 && secondCard.feature2 == thirdCard.feature2) ||
            (firstCard.feature2 != secondCard.feature2 && secondCard.feature2 != thirdCard.feature2 && firstCard.feature2 != thirdCard.feature2)
        ) &&
        (
            (firstCard.feature3 == secondCard.feature3 && secondCard.feature3 == thirdCard.feature3) ||
            (firstCard.feature3 != secondCard.feature3 && secondCard.feature3 != thirdCard.feature3 && firstCard.feature3 != thirdCard.feature3)
        ) &&
        (
            (firstCard.feature4 == secondCard.feature4 && secondCard.feature4 == thirdCard.feature4) ||
            (firstCard.feature4 != secondCard.feature4 && secondCard.feature4 != thirdCard.feature4 && firstCard.feature4 != thirdCard.feature4)
        )
    }
}

fileprivate struct Constants {
    static let SELECTION_COUNT = 3
}
