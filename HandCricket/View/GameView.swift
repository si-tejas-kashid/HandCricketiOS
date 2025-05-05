//
//  GameView.swift
//  HandCricket
//
//  Created by Darshana Kamble on 30/04/25.
//

import SwiftUI

struct GameHeaderView: View {
    let playerName: String
    let opponentName: String
    let playerScore: Int
    let playerWickets: Int
    let playerOvers: Double
    let opponentScore: Int
    let opponentWickets: Int
    let opponentOvers: Double
    let playerIsBatting: Bool
    let opponentIsBatting: Bool
    let totalWickets: Int

    var body: some View {
        VStack(spacing: 0) {
            // Top bar (simulate your app's top bar)
            HStack {
                Button(action: {/* back action */}) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("Back to Home")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.navy)

            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(playerName)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.navy)
                        .padding(.leading, 8)
                    HStack(spacing: 8) {
                        Image(systemName: playerIsBatting ? "sportscourt" : "circle")
                            .foregroundColor(.gold)
                            .background(Circle().fill(Color.navy).frame(width: 28, height: 28))
                        Text("\(playerScore)/\(playerWickets)")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        Text("(\(String(format: "%.1f", playerOvers)) Over)")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 4) {
                        ForEach(0..<totalWickets, id: \ .self) { i in
                            Image(systemName: "circle.fill")
                                .foregroundColor(i < playerWickets ? .gray : .navy)
                                .frame(width: 18, height: 18)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.gold.opacity(0.2))
                .cornerRadius(8)

                ZStack {
                    Circle()
                        .fill(Color.navy)
                        .frame(width: 80, height: 80)
                        .overlay(Circle().stroke(Color.gold, lineWidth: 8))
                    Image(systemName: "sportscourt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
                .offset(y: -20)

                VStack(alignment: .trailing, spacing: 8) {
                    Text(opponentName)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.navy)
                        .padding(.trailing, 8)
                    HStack(spacing: 8) {
                        Image(systemName: opponentIsBatting ? "sportscourt" : "circle")
                            .foregroundColor(.gold)
                            .background(Circle().fill(Color.navy).frame(width: 28, height: 28))
                        if opponentIsBatting {
                            Text("\(opponentScore)/\(opponentWickets)")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            Text("(\(String(format: "%.1f", opponentOvers)) Over)")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.white)
                        } else {
                            Text("Yet to Bat")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.white)
                        }
                    }
                    HStack(spacing: 4) {
                        ForEach(0..<totalWickets, id: \ .self) { i in
                            Image(systemName: "circle.fill")
                                .foregroundColor(i < opponentWickets ? .gray : .navy)
                                .frame(width: 18, height: 18)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.gold.opacity(0.1))
                .cornerRadius(8)
            }
            .background(Color.navy.opacity(0.9))
        }
    }
}

struct GameView: View {
    let initialBatter: InitialBatterType
    @StateObject private var viewModel: GameViewModel
    @State private var showSettings = false
    
    init(initialBatter: InitialBatterType) {
        self.initialBatter = initialBatter
        _viewModel = StateObject(wrappedValue: GameViewModel(initialBatter: initialBatter))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GameHeaderView(
                playerName: viewModel.playerName,
                opponentName: "Computer",
                playerScore: viewModel.playerScore,
                playerWickets: 0, // TODO: wire up
                playerOvers: 0.0, // TODO: wire up
                opponentScore: viewModel.computerScore,
                opponentWickets: 0, // TODO: wire up
                opponentOvers: 0.0, // TODO: wire up
                playerIsBatting: viewModel.currentBatter == .player,
                opponentIsBatting: viewModel.currentBatter == .computer,
                totalWickets: 6 // or whatever your game uses
            )
            VStack(spacing: 20) {
                // Game Header
                Text("Hand Cricket")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Game Status
                Text(viewModel.gameStatus)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(height: 60)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                // Scoreboard
                HStack(spacing: 40) {
                    VStack {
                        Text("You")
                            .font(.headline)
                        Text("\(viewModel.playerScore)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    VStack {
                        Text("Computer")
                            .font(.headline)
                        Text("\(viewModel.computerScore)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                
                // Last Moves
                if viewModel.gameState != .notStarted {
                    HStack(spacing: 40) {
                        VStack {
                            Text("Your last move")
                                .font(.caption)
                            Text("\(viewModel.lastPlayerMove)")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        
                        VStack {
                            Text("Computer's move")
                                .font(.caption)
                            Text("\(viewModel.lastComputerMove)")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                }
                
                // Game Controls
                if viewModel.gameState == .notStarted {
                    Button("Start New Game") {
                        viewModel.startNewGame()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } else if viewModel.gameState == .gameOver {
                    Button("Play Again") {
                        viewModel.startNewGame()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } else {
                    // Number pad for gameplay
                    VStack(spacing: 15) {
                        Text("Choose your move")
                            .font(.headline)
                        
                        HStack(spacing: 20) {
                            ForEach(1...3, id: \.self) { number in
                                numberButton(number)
                            }
                        }
                        
                        HStack(spacing: 20) {
                            ForEach(4...6, id: \.self) { number in
                                numberButton(number)
                            }
                        }
                    }
                    .padding()
                }
                
                // Settings Button
                Button(action: {
                    showSettings = true
                }) {
                    Label("Settings", systemImage: "gear")
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(playerName: $viewModel.playerName)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func numberButton(_ number: Int) -> some View {
        Button(action: {
            viewModel.makeMove(number: number)
        }) {
            Text("\(number)")
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
        }
    }
}

struct SettingsView: View {
    @Binding var playerName: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player Settings")) {
                    TextField("Your Name", text: $playerName)
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

#Preview {
    GameView(initialBatter: .player)
} 