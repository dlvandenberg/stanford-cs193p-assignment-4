//
//  Sequence.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import Foundation

extension Sequence {
    func combinations(sample: Int) -> [[Self.Element]] {
        return combinations(elements: ArraySlice(self), sample: sample)
    }
    
    private func combinations(elements: ArraySlice<Self.Element>, sample: Int) -> [[Self.Element]] {
        if sample == 0 {
            return [[]]
        }
        
        guard let first = elements.first else {
            return []
        }
        
        let head = [first]
        let subCombos = combinations(elements: elements.dropFirst(), sample: sample - 1)
        var combos = subCombos.map { head + $0 }
        combos += combinations(elements: elements.dropFirst(), sample: sample)
        
        return combos
    }
}
