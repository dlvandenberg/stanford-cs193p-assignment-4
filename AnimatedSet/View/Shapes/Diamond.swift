//
//  Diamond.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let top = CGPoint(x: rect.midX, y: rect.maxY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.minY)
        
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        
        return p
    }
}
