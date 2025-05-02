//
//  HomeViewModel.swift
//  HandCricket
//
//  Created by Darshana Kamble on 30/04/25.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var username: String = "Mahesh"
    @Published var points: Int = 350
    
    let tabs = ["Home", "Leaderboard", "How to Play", "Prizes"]
    let gameModes: [GameMode] = GameMode.allCases
    
    func formattedPoints() -> String {
        return "\(points) Pts"
    }
    
    func selectTab(_ index: Int) {
        selectedTab = index
    }
    
    func startGame(mode: GameMode) {
        print("Starting game in mode: \(mode.rawValue)")
        // Here you would implement the navigation logic to the game screen
        // For example, using a NavigationLink or presenting a new view
    }
} 