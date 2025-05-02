//
//  GameModel.swift
//  HandCricket
//
//  Created by Darshana Kamble on 30/04/25.
//

import Foundation

struct Player {
    var name: String
    var score: Int = 0
    var isOut: Bool = false
}

struct GameModel {
    var player: Player
    var computer: Player
    var currentBatter: PlayerType = .player
    var gameState: GameState = .notStarted
    var lastPlayerMove: Int = 0
    var lastComputerMove: Int = 0
    
    enum PlayerType {
        case player
        case computer
    }
    
    enum GameState {
        case notStarted
        case playerBatting
        case computerBatting
        case gameOver
    }
    
    mutating func startNewGame(playerName: String) {
        player = Player(name: playerName)
        computer = Player(name: "Computer")
        gameState = .playerBatting
        currentBatter = .player
    }
    
    func generateComputerMove() -> Int {
        return Int.random(in: 1...6)
    }
    
    mutating func playTurn(playerMove: Int) {
        lastPlayerMove = playerMove
        lastComputerMove = generateComputerMove()
        
        if lastPlayerMove == lastComputerMove {
            // Out!
            if currentBatter == .player {
                player.isOut = true
                currentBatter = .computer
                gameState = .computerBatting
            } else {
                computer.isOut = true
                gameState = .gameOver
            }
        } else {
            // Score runs
            if currentBatter == .player {
                player.score += lastPlayerMove
            } else {
                computer.score += lastComputerMove
            }
            
            // Check if second inning is over
            if currentBatter == .computer && computer.score > player.score {
                gameState = .gameOver
            }
        }
    }
    
    func getWinner() -> PlayerType? {
        guard gameState == .gameOver else { return nil }
        return player.score > computer.score ? .player : .computer
    }
} 