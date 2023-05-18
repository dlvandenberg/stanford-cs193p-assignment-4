//
//  SetCard.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import Foundation

/// Defines a card
protocol SetCard: Hashable {
    // MARK: Types
    associatedtype Identifier: Hashable
    associatedtype Feature1: CardFeature
    associatedtype Feature2: CardFeature
    associatedtype Feature3: CardFeature
    associatedtype Feature4: CardFeature
    
    // MARK: Readonly Properties
    var id: Identifier { get }
    var feature1: Feature1 { get }
    var feature2: Feature2 { get }
    var feature3: Feature3 { get }
    var feature4: Feature4 { get }
    
    // MARK: Writeable Properties
    var isSelected: Bool { get set }
    var isMatched: Bool { get set }
    var isMismatched: Bool { get set }
    var isHint: Bool { get set }
    
    // MARK: Initialiser
    init(feature1: Feature1, feature2: Feature2, feature3: Feature3, feature4: Feature4)
}

/// Defines a Card Feature
protocol CardFeature: Hashable, CaseIterable {}

//// MARK: Extensions
//extension Card: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(feature1)
//        hasher.combine(feature2)
//        hasher.combine(feature3)
//        hasher.combine(feature4)
//    }
//
//    static func == (lhs: Card, rhs: Card) -> Bool {
//        lhs.feature1 == rhs.feature1
//        && lhs.feature2 == rhs.feature2
//        && lhs.feature3 == rhs.feature3
//        && lhs.feature4 == rhs.feature4
//    }
//}
