//
//  TopBarView.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct TopBarView: View {
    var score: Int
    var hintsRemaining: Int
    var showHint: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button("Hint (\(hintsRemaining))") {
                    showHint()
                }
                .font(.title3)
                .disabled(hintsRemaining == 0)
                
                Spacer()
            }
            
            HStack(alignment: .center) {
                Text("Score: \(score)")
            }
        }
        .padding(.horizontal, 25)
        .padding(.top, 5)
    }
}

struct ScoreBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(score: 1, hintsRemaining: 0, showHint: { print("Hint please!") })
    }
}

