//
//  GameViewModel.swift
//  HandCricket
//
//  Created by Darshana Kamble on 30/04/25.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var model: GameModel
    @Published var playerName: String = "Player 1"
    @Published var gameStatus: String = "Welcome to Hand Cricket!"
    
    init() {
        self.model = GameModel(
            player: Player(name: "Player 1"),
            computer: Player(name: "Computer")
        )
    }
    
    // MARK: - Access to Model Properties
    
    var playerScore: Int {
        model.player.score
    }
    
    var computerScore: Int {
        model.computer.score
    }
    
    var gameState: GameModel.GameState {
        model.gameState
    }
    
    var currentBatter: GameModel.PlayerType {
        model.currentBatter
    }
    
    var lastPlayerMove: Int {
        model.lastPlayerMove
    }
    
    var lastComputerMove: Int {
        model.lastComputerMove
    }
    
    // MARK: - Intent Functions
    
    func startNewGame() {
        model.startNewGame(playerName: playerName)
        updateGameStatus()
    }
    
    func makeMove(number: Int) {
        model.playTurn(playerMove: number)
        updateGameStatus()
    }
    
    private func updateGameStatus() {
        switch model.gameState {
        case .notStarted:
            gameStatus = "Press 'Start Game' to begin"
        case .playerBatting:
            gameStatus = "You're batting. Choose a number (1-6)"
        case .computerBatting:
            gameStatus = "Computer is batting. Choose a number (1-6)"
        case .gameOver:
            if let winner = model.getWinner() {
                if winner == .player {
                    gameStatus = "Game Over. You won! \(playerScore) - \(computerScore)"
                } else {
                    gameStatus = "Game Over. Computer won! \(computerScore) - \(playerScore)"
                }
            } else {
                gameStatus = "Game Over. It's a tie! \(playerScore) - \(computerScore)"
            }
        }
    }
} 