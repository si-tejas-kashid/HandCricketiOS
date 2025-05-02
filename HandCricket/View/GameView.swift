//
//  GameView.swift
//  HandCricket
//
//  Created by Darshana Kamble on 30/04/25.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var showSettings = false
    
    var body: some View {
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
    GameView()
} 