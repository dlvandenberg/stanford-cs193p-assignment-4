//
//  StripedView.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct StripedView: View {
    var shape: AnyShape
    var color: Color
    
    var body: some View {
        HStack(spacing: Constants.stripeSpacing) {
            ForEach(0 ..< 10) { _ in
                Color.white
                color
            }
            Color.white
        }
        .mask(shape)
        .overlay(shape.stroke(color, lineWidth: Constants.strokeWidth))
    }
}

fileprivate struct Constants {
    static let stripeSpacing: CGFloat = 0.5
    static let strokeWidth: CGFloat = 1.3
}

struct StripedView_Previews: PreviewProvider {
    static var previews: some View {
        StripedView(shape: AnyShape(Squiggle()), color: .red)
    }
}

