//
//  Card.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import Foundation

struct Card: SetCard {
    // MARK: Type alias
    typealias Identifier = UUID
    
    var feature1: ShapeFeature
    var feature2: ColorFeature
    var feature3: ShadingFeature
    var feature4: ShapeCountFeature
    
    var id = UUID()
    var isSelected = false
    var isMatched = false
    var isMismatched = false
    var isHint = false
    
    init(feature1: ShapeFeature, feature2: ColorFeature, feature3: ShadingFeature, feature4: ShapeCountFeature) {
        self.feature1 = feature1
        self.feature2 = feature2
        self.feature3 = feature3
        self.feature4 = feature4
    }
    
    enum ShapeFeature: CardFeature {
        case oval
        case diamond
        case squiggle
    }
    
    enum ColorFeature: CardFeature {
        case red
        case purple
        case green
    }
    
    enum ShadingFeature: CardFeature {
        case solid
        case striped
        case outline
    }
    
    enum ShapeCountFeature: CardFeature {
        case one
        case two
        case three
    }
}
