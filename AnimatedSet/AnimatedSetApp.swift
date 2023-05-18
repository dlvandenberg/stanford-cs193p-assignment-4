//
//  AnimatedSetApp.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import SwiftUI

@main
struct AnimatedSetApp: App {
    private let game = SetViewModel()
    var body: some Scene {
        WindowGroup {
            SetView(game: game)
        }
    }
}
