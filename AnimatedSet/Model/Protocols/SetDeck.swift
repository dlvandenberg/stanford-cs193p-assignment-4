//
//  SetDeck.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import Foundation

protocol SetDeck {
    associatedtype CardType: SetCard
    
    var cards: Set<CardType> { get set }
    var isEmpty: Bool { get }
    var count: Int { get }
    
    mutating func deal(amount: Int) -> [CardType]
    mutating func deal() -> [CardType]
}

// MARK: Default implementations
// MARK: Computed properties
extension SetDeck {
    var isEmpty: Bool { cards.isEmpty }
    var count: Int { cards.count }
}

// MARK: Method implementations
extension SetDeck {
    mutating func deal(amount: Int) -> [CardType] {
        if isEmpty {
            return []
        }
        let numberOfCards = min(count, amount)
        return (0..<numberOfCards).map { _ in cards.removeFirst() }
    }
    
    mutating func deal() -> [CardType] {
        deal(amount: Constants.DEFAULT_CARDS_TO_DEAL)
    }
}

// MARK: Card Generation
extension SetDeck {
    typealias Feature1 = CardType.Feature1
    typealias Feature2 = CardType.Feature2
    typealias Feature3 = CardType.Feature3
    typealias Feature4 = CardType.Feature4
    
    static func generateCards() -> [CardType] {
        Feature1.allCases.flatMap { generateCards(feature1: $0) }.shuffled()
    }
    
    private static func generateCards(feature1: Feature1) -> [CardType] {
        Feature2.allCases.flatMap { generateCards(feature1: feature1, feature2: $0) }
    }
    
    private static func generateCards(feature1: Feature1, feature2: Feature2) -> [CardType] {
        Feature3.allCases.flatMap { generateCards(feature1: feature1, feature2: feature2, feature3: $0) }
    }
    
    private static func generateCards(feature1: Feature1, feature2: Feature2, feature3: Feature3) -> [CardType] {
        Feature4.allCases.map { CardType(feature1: feature1, feature2: feature2, feature3: feature3, feature4: $0) }
    }
}

fileprivate struct Constants {
    static let DEFAULT_CARDS_TO_DEAL = 3
}
