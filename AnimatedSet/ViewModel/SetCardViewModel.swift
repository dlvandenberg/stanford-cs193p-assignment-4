//
//  SetCardViewModel.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct SetCardViewModel: Identifiable {
    // MARK: Properties
    private var _card: Card
    
    // MARK: Computed properties
    var id: UUID {
        _card.id
    }
    var isSelected: Bool {
        _card.isSelected
    }
    var isMatched: Bool {
        _card.isMatched
    }
    var isMismatched: Bool {
        _card.isMismatched
    }
    var isHint: Bool {
        _card.isHint
    }
    
    // MARK: Features
    var shape: AnyShape {
        switch _card.feature1 {
        case .diamond: return AnyShape(Diamond())
        case .oval: return AnyShape(Oval())
        case .squiggle: return AnyShape(Squiggle())
        }
    }
    
    var color: Color {
        switch _card.feature2 {
        case .green: return .green
        case .purple: return .purple
        case .red: return .red
        }
    }
    
    var shading: CardShading {
        switch _card.feature3 {
        case .outline: return .outline
        case .solid: return .solid
        case .striped: return .striped
        }
    }
    
    var shapeCount: Int {
        switch _card.feature4 {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        }
    }
    
    // MARK: Initialiser
    init(_ card: Card) {
        self._card = card
    }
    
    enum CardShading {
        case outline
        case solid
        case striped
    }
}
