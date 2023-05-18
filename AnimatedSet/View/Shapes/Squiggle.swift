//
//  Squiggle.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

struct Squiggle: Shape {
    let startPoint = CGPoint(x: 40, y: 0)
    var curvePoints = [
        CurvePoint(to: CGPoint(x: 0, y: 35), control1: CGPoint(x: 30, y: 0), control2: CGPoint(x: 0, y: 5)),
        CurvePoint(to: CGPoint(x: 40, y: 55), control1: CGPoint(x: 0, y: 80), control2: CGPoint(x: 20, y: 65)),
        CurvePoint(to: CGPoint(x: 90, y: 55), control1: CGPoint(x: 50, y: 50), control2: CGPoint(x: 80, y: 50)),
        CurvePoint(to: CGPoint(x: 135, y: 20), control1: CGPoint(x: 110, y: 65), control2: CGPoint(x: 135, y: 55)),
        CurvePoint(to: CGPoint(x: 110, y: 10), control1: CGPoint(x: 135, y: 0), control2: CGPoint(x: 130, y: -10)),
        CurvePoint(to: CGPoint(x: 40, y: 0), control1: CGPoint(x: 95, y: 25), control2: CGPoint(x: 65, y: 0)),
    ]
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: startPoint)
        
        for curvePoint in curvePoints {
            p.addCurve(to: curvePoint.point, control1: curvePoint.control1, control2: curvePoint.control2)
        }
        
        p.closeSubpath()

        let pathRect = p.boundingRect
        p = p.offsetBy(dx: rect.minX - pathRect.minX, dy: rect.minY - pathRect.minY)

        let scale: CGFloat = rect.width / pathRect.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        p = p.applying(transform)

        return p
    }
    
    struct CurvePoint: Hashable {
        var point: CGPoint
        var control1: CGPoint
        var control2: CGPoint
        
        init(to point: CGPoint, control1: CGPoint, control2: CGPoint) {
            self.point = point
            self.control1 = control1
            self.control2 = control2
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(point.x)
            hasher.combine(point.y)
            hasher.combine(control1.x)
            hasher.combine(control1.y)
        }
    }
}

