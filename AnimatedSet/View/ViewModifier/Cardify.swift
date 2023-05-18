//
//  Cardify.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    private var isSelected: Bool
    private var isMatched: Bool
    private var isMismatched: Bool
    private var isHint: Bool
    
    init(isFaceUp: Bool, isSelected: Bool, isMatched: Bool, isMismatched: Bool, isHint: Bool) {
        rotation = isFaceUp ? 0 : 180
        
        self.isSelected = isSelected
        self.isMismatched = isMismatched
        self.isMatched = isMatched
        self.isHint = isHint
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    var cardInIncompleteSet: Bool {
        isSelected && !isMatched && !isMismatched
    }
    var cardInSet: Bool {
        isSelected
    }
    
    private var borderColor: Color {
        if isSelected {
            return isMatched ? .green : (isMismatched ? .red : .teal)
        } else {
            return isHint ? .yellow : .white
        }
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if rotation < 90 {
                    // Card is turning face up
                    if isHint {
                        cardShape.fill(.white).opacity(0.75)
                    } else {
                        cardShape.fill(.white)
                    }
                    
                    cardShape.strokeBorder(borderColor, lineWidth: DrawingConstants.strokeWidth)
                } else {
                    // Card is still face down
                    cardShape.fill()
                }
                
                content
                    .opacity(rotation < 90 ? 1 : 0)
            }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
        }
    }

    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let strokeWidth: CGFloat = 2.5
    }
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, isMatched: Bool, isMismatched: Bool, isHint: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, isMatched: isMatched, isMismatched: isMismatched, isHint: isHint))
    }
}
