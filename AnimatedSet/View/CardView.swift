//
//  CardView.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct CardView: View {
    var card: SetCardViewModel
    var isFaceUp: Bool
    
    init(_ card: SetCardViewModel, isFaceUp: Bool) {
        self.card = card
        self.isFaceUp = isFaceUp
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let relativePadding = geometry.size.width * DrawingConstants.paddingFactor
                let relativeSpacing = geometry.size.width * DrawingConstants.spacingFactor
                VStack(spacing: relativeSpacing) {
                    ForEach(1...card.shapeCount, id: \.self) { _ in
                        ShapeView(shape: card.shape, color: card.color, shading: card.shading)
                    }
                }
                .padding(.horizontal, relativePadding)
            }
            .cardify(isFaceUp: isFaceUp, isSelected: card.isSelected, isMatched: card.isMatched, isMismatched: card.isMismatched, isHint: card.isHint)
            .aspectRatio(DrawingConstants.cardAspectRatio, contentMode: .fit)
        }
    }

    private struct DrawingConstants {
        static let paddingFactor: CGFloat = 0.10
        static let spacingFactor: CGFloat = 0.07
        static let cornerRadius: CGFloat = 10
        static let strokeWidth: CGFloat = 2.5
        static let cardAspectRatio: CGFloat = 2/3
    }
}

//struct CardView_Previews: PreviewProvider {
//
//    static var previews: some View {
//            ZStack {
//                Rectangle()
//                    .ignoresSafeArea(.all)
//                CardView(SetCardViewModel(Card(feature1: .squiggle, feature2: .green, feature3: .striped, feature4: .two)))
////                    .frame(width: 80)
//            }
//
//            ZStack {
//                Rectangle()
//                    .ignoresSafeArea(.all)
//                CardView(SetCardViewModel(Card(feature1: .squiggle, feature2: .green, feature3: .striped, feature4: .three)))
//                    .frame(width: 50)
//            }
//
//        ZStack {
//            Rectangle()
//                .ignoresSafeArea(.all)
//            CardView(SetCardViewModel(Card(feature1: .squiggle, feature2: .green, feature3: .striped, feature4: .one)))
//                .frame(width: 200)
//        }
//    }
//}
