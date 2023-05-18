//
//  Oval.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let radius = rect.height / 2
        let leftMidX = rect.minX + radius
        let rightMidX = rect.maxX - radius
        let leftCenter = CGPoint(x: leftMidX, y: rect.midY)
        let start = CGPoint(x: leftMidX, y: rect.maxY)
        let rightCenter = CGPoint(x: rightMidX, y: rect.midY)
        let topRight = CGPoint(x: rightMidX, y: rect.minY)
        
        p.move(to: start)
        p.addArc(center: leftCenter, radius: radius, startAngle: OvalConstants.bottomAngle, endAngle: OvalConstants.topAngle, clockwise: false)
        p.addLine(to: topRight)
        p.addArc(center: rightCenter, radius: radius, startAngle: OvalConstants.topAngle, endAngle: OvalConstants.bottomAngle, clockwise: false)
        p.addLine(to: start)
        return p
    }
    
    private struct OvalConstants {
        static let bottomAngle = Angle(degrees: 90)
        static let topAngle = Angle(degrees: 270)
    }
}

