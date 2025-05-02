//
//  GameMode.swift
//  HandCricket
//
//  Created by Darshana Kamble on 30/04/25.
//

import Foundation

enum GameMode: String, CaseIterable, Identifiable {
    case titan = "TITAN"
    case titansFam = "TITANS FAM"
    case friend = "FRIEND"
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .titan:
            return "Play against the Titan AI in a classic Hand Cricket match"
        case .titansFam:
            return "Compete against other Titan Family members"
        case .friend:
            return "Challenge friends with a room code for casual matches!"
        }
    }
    
    var remainingWickets: String? {
        switch self {
        case .titansFam:
            return "2/10"
        default:
            return nil
        }
    }
} 