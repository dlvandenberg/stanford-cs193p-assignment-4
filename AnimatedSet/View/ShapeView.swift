//
//  ShapeView.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct ShapeView: View {
    typealias Shading = SetCardViewModel.CardShading
    
    var shape: AnyShape
    var color: Color
    var shading: Shading
    
    @ViewBuilder
    var body: some View {
        switch shading {
        case .solid:
            shape
                .fill()
                .foregroundColor(color)
                .aspectRatio(Constants.aspectRatio, contentMode: .fit)
        case .outline:
            shape
                .stroke(lineWidth: Constants.strokeWidth)
                .foregroundColor(color)
                .aspectRatio(Constants.aspectRatio, contentMode: .fit)
        case .striped:
            StripedView(shape: shape, color: color)
                .aspectRatio(Constants.aspectRatio, contentMode: .fit)
        }
    }
}

fileprivate struct Constants {
    static let aspectRatio: CGFloat = 2/1
    static let strokeWidth: CGFloat = 1.3
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeView(shape: AnyShape(Squiggle()), color: .red, shading: .solid)
        ShapeView(shape: AnyShape(Squiggle()), color: .green, shading: .striped)
        ShapeView(shape: AnyShape(Squiggle()), color: .purple, shading: .outline)
    }
}
