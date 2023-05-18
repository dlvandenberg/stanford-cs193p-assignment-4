//
//  ActionBarView.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct ActionBarView: View {
    var canDeal: Bool
    var deal: () -> Void
    var newGame: () -> Void
    
    var body: some View {
        HStack {
            Button("Deal") {
                deal()
            }
            .font(.title2)
            .disabled(!canDeal)
            
            Spacer()
            
            Button("New game") {
                newGame()
            }
            .font(.title2)
            .foregroundColor(.red)
        }
        .padding(.horizontal, 25)
    }
}

struct ActionBarView_Previews: PreviewProvider {
    static var previews: some View {
        ActionBarView(canDeal: true, deal: { print("Deal") }, newGame: { print("New game") })
    }
}

