//
//  SetView.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var game: SetViewModel
    
    @Namespace private var dealingNamespace
    
    private func zIndex(of card: SetCardViewModel) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var body: some View {
        let gameFinished = Binding<Bool>(
            get: { self.game.isFinised
            },
            set: { _ in  }
        )
        
        ZStack {
            gameBackground
            
            VStack {
                TopBarView(score: game.score, hintsRemaining: game.availableHints, showHint: game.showHint)
                
                gameBody
                
                HStack {
                    deckBody
                    
                    Spacer()
                    
                    matchedCardsBody
                }
                .padding(5)
            }
        }.alert(
            Text("Finished"),
            isPresented: gameFinished,
            actions: {
                Button("New game", action: { game.newGame() })
            },
            message: {
                Text("Final Score: \(game.score)")
            }
        )
        
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: DrawingConstants.cardAspectRation) { card in
            CardView(card, isFaceUp: true)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(.asymmetric(insertion: .opacity, removal: .identity))
                .zIndex(zIndex(of: card))
                .padding(DrawingConstants.cardSpacing)
                .onTapGesture {
                    withAnimation {
                        game.select(card)
                    }
                }
        }
        .padding(5)
    }
    
    var gameBackground: some View {
        Rectangle()
            .fill(.gray)
            .opacity(0.4)
            .edgesIgnoringSafeArea(.all)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.deck) { card in
                CardView(card, isFaceUp: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(
                        .asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
                    .padding(DrawingConstants.cardSpacing)
            }
        }
        .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
        .foregroundColor(DrawingConstants.cardBackColor)
        .onTapGesture {
            withAnimation {
                if game.canDeal {
                    game.deal()
                }
            }
        }
    }
    
    var matchedCardsBody: some View {
        ZStack {
            ForEach(game.matchedCards) { card in
                CardView(card, isFaceUp: true)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
                    .padding(DrawingConstants.cardSpacing)
            }
        }
        .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
        .foregroundColor(DrawingConstants.cardBackColor)
    }
    
    private struct DrawingConstants {
        static let cardSpacing: CGFloat = 2
        static let cardAspectRation: CGFloat = 2/3
        static let cardMinWidth: CGFloat = 40
        static let cardBackColor = Color.gray
        static let deckHeight: CGFloat = 90
        static let deckWidth = deckHeight * cardAspectRation
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        SetView(game: game)
    }
}
