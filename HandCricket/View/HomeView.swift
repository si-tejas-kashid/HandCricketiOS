//
//  HomeView.swift
//  HandCricket
//
//  Created by Darshana Kamble on 30/04/25.
//

import SwiftUI
import Foundation
import AVKit
import WebKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showPlayHandCricket = false
    @State private var showYouTubeVideo = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                topBar
                goldDivider
                tabView
                ScrollView {
                    VStack(spacing: 32) {
                        // Hand Cricket Logo and Intro
                        if viewModel.selectedTab == 0 {
                            VStack(spacing: 16) {
                                Image("handCricketLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 140)
                                    .padding(.top, 24)
                                Text("Hand Cricket")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Jump into thrilling 1v1 matches with Titan, GT Fam, or friends – fast, fun, and full of challenges!")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                            }
                            // Play Hand Cricket Option
                            Button(action: { showPlayHandCricket = true }) {
                                playHandCricketCard
                            }
                            .buttonStyle(PlainButtonStyle())
                            .background(
                                NavigationLink(
                                    destination: PlayHandCricketView(topBar: AnyView(topBar), goHome: { showPlayHandCricket = false }),
                                    isActive: $showPlayHandCricket
                                ) { EmptyView() }.hidden()
                            )
                            // How to Play Card (on Home, with white background and title)
                            ZStack {
                                Color.white
                                    .clipShape(RoundedRectangle(cornerRadius: 0))
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("How to Play")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.top, 20)
                                        .padding(.leading, 16)
                                    ZStack {
                                        VStack(spacing: 24) {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.white, lineWidth: 2)
                                                if !showYouTubeVideo {
                                                    ZStack {
                                                        Image("howToPlay")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                                        Button(action: { showYouTubeVideo = true }) {
                                                            ZStack {
                                                                Circle()
                                                                    .fill(Color.gold.opacity(0.3))
                                                                    .frame(width: 80, height: 80)
                                                                Circle()
                                                                    .fill(Color.gold)
                                                                    .frame(width: 60, height: 60)
                                                                Image(systemName: "play.fill")
                                                                    .font(.system(size: 30, weight: .bold))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    YouTubePlayerView(videoID: "Y7ilAHfRcQA", autoplay: true)
                                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                                }
                                            }
                                            .frame(height: 260)
                                            .padding(.horizontal, 16)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 0)
                            .padding(.top, 8)
                        }
                        // How to Play Tab Content
                        if viewModel.selectedTab == 2 {
                            VStack(spacing: 24) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 2)
                                    if !showYouTubeVideo {
                                        ZStack {
                                            Image("howToPlay")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                            Button(action: { showYouTubeVideo = true }) {
                                                ZStack {
                                                    Circle()
                                                        .fill(Color.gold.opacity(0.3))
                                                        .frame(width: 80, height: 80)
                                                    Circle()
                                                        .fill(Color.gold)
                                                        .frame(width: 60, height: 60)
                                                    Image(systemName: "play.fill")
                                                        .font(.system(size: 30, weight: .bold))
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                    } else {
                                        YouTubePlayerView(videoID: "Y7ilAHfRcQA", autoplay: true)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                }
                                .frame(height: 260)
                                .padding(.horizontal, 16)
                            }
                            .padding(.top, 32)
                        }
                    }
                }
            }
            .background(Color.navy)
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Top Bar
    private var topBar: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.navy, Color.navy.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                .frame(height: 60)
            HStack(spacing: 10) {
                Text("ICC")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.navy)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Spacer(minLength: 4)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
                Rectangle()
                    .fill(Color.gold.opacity(0.5))
                    .frame(width: 1, height: 24)
                Image(systemName: "message.fill")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
                Rectangle()
                    .fill(Color.gold.opacity(0.5))
                    .frame(width: 1, height: 24)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.navy)
                        .font(.system(size: 15, weight: .bold))
                    Text("350 Pts")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.navy)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.gold, Color.gold.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(14)
                Rectangle()
                    .fill(Color.gold.opacity(0.5))
                    .frame(width: 1, height: 24)
                Text("Mahesh")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                ZStack {
                    Circle()
                        .stroke(Color.gold, lineWidth: 2)
                        .frame(width: 28, height: 28)
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 8)
        }
        .frame(height: 60)
    }
    
    // MARK: - Gold Divider
    private var goldDivider: some View {
        Rectangle()
            .fill(Color.gold)
            .frame(height: 1)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
    // MARK: - Tab View (Menu Bar)
    private var tabView: some View {
        HStack(spacing: 0) {
            ForEach(0..<viewModel.tabs.count, id: \.self) { index in
                Button(action: {
                    viewModel.selectTab(index)
                }) {
                    Text(viewModel.tabs[index])
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(viewModel.selectedTab == index ? .navy : .white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(viewModel.selectedTab == index ? Color.gold : Color.navy)
                }
            }
        }
    }
    
    // MARK: - Play Hand Cricket Card
    private var playHandCricketCard: some View {
        HStack {
            Image("handCricketLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding(.leading, 16)
            VStack(alignment: .leading, spacing: 6) {
                Text("Play Hand Cricket")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                Text("Jump into a match and enjoy fast, fun, and full of challenges!")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
            .padding(.leading, 8)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gold)
                    .frame(width: 44, height: 44)
                Image(systemName: "arrow.right")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.navy)
            }
            .padding(.trailing, 16)
        }
        .frame(height: 100)
        .background(Color.navy.opacity(0.7))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gold, lineWidth: 2)
        )
        .padding(.horizontal, 16)
    }
}

struct PlayHandCricketView: View {
    let topBar: AnyView
    let goHome: () -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var playerName: String = ""
    @State private var savedName: String? = nil
    @State private var showTossScreen: Bool = false
    
    var body: some View {
        ZStack {
            Color.navy.ignoresSafeArea()
            if showTossScreen {
                TossScreen(topBar: topBar, goHome: goHome, onBack: { presentationMode.wrappedValue.dismiss() })
            } else {
                NameEntryScreen(
                    topBar: topBar,
                    goHome: goHome,
                    playerName: $playerName,
                    savedName: $savedName,
                    onSave: { showTossScreen = true },
                    onBack: { presentationMode.wrappedValue.dismiss() }
                )
            }
        }
        .navigationBarHidden(true)
    }
}

struct NameEntryScreen: View {
    let topBar: AnyView
    let goHome: () -> Void
    @Binding var playerName: String
    @Binding var savedName: String?
    var onSave: () -> Void
    var onBack: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            topBar
            Rectangle()
                .fill(Color.gold)
                .frame(height: 1)
            // Back to Home button
            HStack {
                Button(action: goHome) {
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
            .padding(.vertical, 18)
            .background(Color.navy.opacity(0.85))
            Spacer()
            VStack(spacing: 32) {
                // Name Entry Card
                VStack(spacing: 12) {
                    if let name = savedName {
                        Text(name)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.navy)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color(red: 0.97, green: 0.95, blue: 0.89))
                            .cornerRadius(20)
                            .padding(.horizontal, 32)
                    } else {
                        TextField("Your Name", text: $playerName)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color.navy)
                            .padding(.vertical, 18)
                            .padding(.horizontal, 20)
                            .background(Color(red: 0.97, green: 0.95, blue: 0.89))
                            .cornerRadius(20)
                            .padding(.horizontal, 32)
                            .multilineTextAlignment(.center)
                        Button(action: { if !playerName.isEmpty { savedName = playerName; onSave() } }) {
                            Text("Save")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 32)
                                .padding(.vertical, 10)
                                .background(Color.gold)
                                .cornerRadius(12)
                        }
                    }
                }
                // VS Section with gameMessageBg and centered text
                ZStack {
                    Image("gameMessageBg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                    Text("VS")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color.gold)
                }
                .padding(.horizontal, 32)
                // Opponent Name Card
                Text("Computer")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.navy)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color(red: 0.85, green: 0.88, blue: 0.97))
                    .cornerRadius(20)
                    .padding(.horizontal, 32)
            }
            Spacer()
        }
    }
}

// Add an enum for batter type to match GameModel.PlayerType
enum InitialBatterType {
    case player, computer
}

// In TossScreen, add state for navigation and initial batter
struct TossScreen: View {
    let topBar: AnyView
    let goHome: () -> Void
    var onBack: () -> Void
    @State private var selectedToss: TossOption? = nil
    @State private var timerProgress: Double = 0
    @State private var timerActive: Bool = true
    @State private var coinSpinProgress: Double = 0
    @State private var showTossingHand: Bool = false
    @State private var showResult: Bool = false
    @State private var tossResult: TossOption? = nil
    @State private var coinScale: CGFloat = 0.1
    @State private var coinOffset: CGFloat = 0
    @State private var showTossScreen: Bool = false
    @State private var showBatBowlChoice: Bool = false
    @State private var showLoseTossScreen: Bool = false
    @State private var navigateToGame: Bool = false
    @State private var initialBatter: InitialBatterType? = nil
    let timerDuration: Double = 10.0
    let timerInterval: Double = 0.05
    enum TossOption { case heads, tails }
    var body: some View {
        ZStack {
            NavigationLink(
                destination: initialBatter != nil ? GameViewWrapper(initialBatter: initialBatter!) : nil,
                isActive: $navigateToGame
            ) { EmptyView() }.hidden()
            if showLoseTossScreen {
                LoseTossScreen(topBar: topBar, goHome: goHome, onBack: {
                    showLoseTossScreen = false
                }, onTimerEnd: {
                    // Computer randomly selects bat or bowl after timer
                    let computerChoice = computerRandomBatBowlChoice()
                    // If computer chooses to bat, user bowls, and vice versa
                    initialBatter = (computerChoice == .bat) ? .computer : .player
                    navigateToGame = true
                })
            } else if showBatBowlChoice {
                BatBowlChoiceScreen(topBar: topBar, goHome: goHome, onBack: {
                    showBatBowlChoice = false
                    showTossScreen = false
                    showTossingHand = false
                    showResult = false
                    coinScale = 0.1
                }, onSelection: { userChoice in
                    // If user chooses to bat, user bats, else computer bats
                    initialBatter = (userChoice == .bat) ? .player : .computer
                    navigateToGame = true
                })
            } else if showTossScreen {
                VStack(spacing: 0) {
                    topBar
                    Rectangle()
                        .fill(Color.gold)
                        .frame(height: 1)
                    // Back to Home button
                    HStack {
                        Button(action: goHome) {
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
                    .padding(.vertical, 18)
                    .background(Color.navy.opacity(0.85))
                    Spacer()
                    if showTossingHand {
                        // Tossing Hand Animation
                        Image("tossingHand")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .transition(.scale.combined(with: .opacity))
                    }
                    if showResult {
                        // Result Coin (no text)
                        Image(tossResult == .heads ? "headsToss" : "tailsToss")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .scaleEffect(coinScale)
                            .offset(y: coinOffset)
                            .shadow(radius: 10)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                                    coinScale = coinScale == 1.0 ? 1.2 : 1.0
                                }
                            }
                            .onAppear {
                                // If user wins, show coin for 1.2s then go to Bat/Bowl choice
                                if tossResult == selectedToss {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        showResult = false
                                        showBatBowlChoice = true
                                    }
                                } else {
                                    // User loses toss
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        showResult = false
                                        showLoseTossScreen = true
                                    }
                                }
                            }
                    }
                    Spacer()
                }
                .background(Color.navy)
                .onAppear {
                    // First show tossing hand
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showTossingHand = true
                    }
                    // After 2 seconds, hide tossing hand and show result
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showTossingHand = false
                        }
                        // After tossing hand is hidden, show result
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showResult = true
                                tossResult = Bool.random() ? .heads : .tails
                            }
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                                coinScale = 1.0
                            }
                        }
                    }
                }
            } else {
                VStack(spacing: 0) {
                    topBar
                    Rectangle()
                        .fill(Color.gold)
                        .frame(height: 1)
                    // Back to Home button
                    HStack {
                        Button(action: goHome) {
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
                    .padding(.vertical, 18)
                    .background(Color.navy.opacity(0.85))
                    ScrollView {
                        VStack(spacing: 24) {
                            // TOSS Header with gameMessageBg and centered text
                            ZStack {
                                Image("gameMessageBg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 80)
                                Text("TOSS")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(Color.gold)
                            }
                            Text("Select heads or tails.")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                            // Timer
                            TimerHourglassView(progress: min(timerProgress, 1.0))
                                .frame(width: 36, height: 36)
                                .padding(.bottom, 8)
                            // Toss Options with checkboxes below
                            HStack(spacing: 24) {
                                VStack(spacing: 8) {
                                    tossOptionView(option: .heads, imageName: "headsToss", label: "HEADS")
                                        .onTapGesture {
                                            selectedToss = .heads
                                        }
                                    Button(action: { selectedToss = .heads }) {
                                        radioButton(selected: selectedToss == .heads)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                VStack(spacing: 8) {
                                    tossOptionView(option: .tails, imageName: "tailsToss", label: "TAILS")
                                        .onTapGesture {
                                            selectedToss = .tails
                                        }
                                    Button(action: { selectedToss = .tails }) {
                                        radioButton(selected: selectedToss == .tails)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            // Play Toss Button
                            Button(action: {
                                showTossScreen = true
                            }) {
                                Text("Play Toss")
                                    .font(.system(size: 28, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(
                                        Group {
                                            if selectedToss != nil {
                                                LinearGradient(gradient: Gradient(colors: [Color.gold, Color.gold.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                            } else {
                                                Color.navy.opacity(0.5)
                                            }
                                        }
                                    )
                                    .foregroundColor(selectedToss != nil ? .navy : .gray)
                                    .cornerRadius(24)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(selectedToss != nil ? Color.gold : Color.gray.opacity(0.5), lineWidth: 3)
                                    )
                                    .padding(.horizontal, 24)
                            }
                            .disabled(selectedToss == nil && timerProgress < 1.0)
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 40)
                        .onChange(of: timerProgress) { newValue in
                            if newValue >= 1.0 && selectedToss == nil {
                                // Timer ended and no selection, randomly select and proceed
                                selectedToss = Bool.random() ? .heads : .tails
                                showTossScreen = true
                            }
                        }
                    }
                    .background(Color.navy)
                }
                .background(Color.navy)
                .onAppear {
                    timerActive = true
                    timerProgress = 0
                    startTimer()
                    // Start coin spin animation
                    withAnimation(.easeInOut(duration: 0.5)) {
                        coinSpinProgress = 1.0
                    }
                }
                .onDisappear {
                    timerActive = false
                    coinSpinProgress = 0
                }
            }
        }
    }
    
    func tossOptionView(option: TossOption, imageName: String, label: String) -> some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color(red: 0.19, green: 0.25, blue: 0.39))
                    .frame(width: 150, height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(selectedToss == option ? Color.gold : Color.clear, lineWidth: 1.5)
                    )
                // Shadow
                Circle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 60, height: 20)
                    .offset(y: 50)
                    .blur(radius: 5)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .shadow(radius: 8)
                    .rotation3DEffect(
                        .degrees(coinSpinProgress * 360),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        perspective: 0.5
                    )
            }
            Text(label)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
    func radioButton(selected: Bool) -> some View {
        ZStack {
            Circle()
                .stroke(selected ? Color.clear : Color.gold.opacity(0.5), lineWidth: 4)
                .frame(width: 36, height: 36)
            if selected {
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.gold, Color.gold.opacity(0.85)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.navy)
                    )
            }
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            if !timerActive { timer.invalidate(); return }
            if timerProgress < 1.0 {
                timerProgress += timerInterval / timerDuration
            } else {
                timerProgress = 1.0
                timer.invalidate()
                timerActive = false
                if selectedToss == nil {
                    selectedToss = Bool.random() ? .heads : .tails
                }
            }
        }
    }
}

struct TimerHourglassView: View {
    var progress: Double // 0.0 to 1.0
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.19, green: 0.25, blue: 0.39))
            Arc(startAngle: .degrees(-90), endAngle: .degrees(-90 + 360 * progress), clockwise: false)
                .stroke(Color.gold, style: StrokeStyle(lineWidth: 5, lineCap: .round))
            Image("hourglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
        }
        .frame(width: 36, height: 36)
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)
        return path
    }
}

// Custom colors
extension Color {
    static let navy = Color(hex: "#0B1D34")
    static let gold = Color(hex: "#D8B463")
}

// Extension to create Color from hex string
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 11, 29, 52) // Default to #0B1D34 if invalid format
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Placeholder for missing assets - in a real app, you'd replace these with actual images
struct ImagePlaceholder: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            )
    }
}

extension Image {
    static func placeholder() -> some View {
        ImagePlaceholder()
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    let autoplay: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .black
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        var urlString = "https://www.youtube.com/embed/\(videoID)?playsinline=1"
        if autoplay {
            urlString += "&autoplay=1"
        }
        guard let youtubeURL = URL(string: urlString) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}

struct BatBowlChoiceScreen: View {
    let topBar: AnyView
    let goHome: () -> Void
    var onBack: () -> Void
    @State private var selected: Choice? = nil
    enum Choice { case bat, bowl }
    // Timer logic for auto-select
    @State private var timerProgress: Double = 0
    @State private var timerActive: Bool = true
    let timerDuration: Double = 7.0 // seconds to choose
    let timerInterval: Double = 0.05
    var onSelection: (Choice) -> Void

    var body: some View {
        VStack(spacing: 0) {
            topBar
            Rectangle()
                .fill(Color.gold)
                .frame(height: 1)
            // Back to Home button
            HStack {
                Button(action: goHome) {
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
            .padding(.vertical, 18)
            .background(Color.navy.opacity(0.85))
            VStack(spacing: 16) {
                ZStack(alignment: .top) {
                    Image("gameMessageBg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                    Text("TOSS WIN")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 24)
                }
                
                Text("You won the toss! Choose to bat or bowl.")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                TimerHourglassView(progress: min(timerProgress, 1.0))
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 8)
                HStack(spacing: 24) {
                    // Bat Option + radio
                    VStack(spacing: 20) {
                        Button(action: { selected = .bat }) {
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.19, green: 0.25, blue: 0.39))
                                        .frame(width: 80, height: 80)
                                    Image("batting")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 44, height: 44)
                                }
                                Text("BAT")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 170, height: 200)
                            .background(Color(red: 0.29, green: 0.36, blue: 0.54))
                            .cornerRadius(28)
                            .overlay(
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(selected == .bat ? Color.gold : Color.clear, lineWidth: 4)
                            )
                            .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 4)
                        }
                        Button(action: { selected = .bat }) {
                            ZStack {
                                if selected == .bat {
                                    Circle()
                                        .fill(Color.gold)
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Circle()
                                                .stroke(Color(hex: "#BD9E5E"), lineWidth: 3)
                                        )
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.navy)
                                } else {
                                    Circle()
                                        .fill(Color.navy)
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.gold, lineWidth: 4)
                                        )
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    // Bowl Option + radio
                    VStack(spacing: 20) {
                        Button(action: { selected = .bowl }) {
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.19, green: 0.25, blue: 0.39))
                                        .frame(width: 80, height: 80)
                                    Image("bowling")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 44, height: 44)
                                }
                                Text("BOWL")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 170, height: 200)
                            .background(Color(red: 0.29, green: 0.36, blue: 0.54))
                            .cornerRadius(28)
                            .overlay(
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(selected == .bowl ? Color.gold : Color.clear, lineWidth: 4)
                            )
                            .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 4)
                        }
                        Button(action: { selected = .bowl }) {
                            ZStack {
                                if selected == .bowl {
                                    Circle()
                                        .fill(Color.gold)
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Circle()
                                                .stroke(Color(hex: "#BD9E5E"), lineWidth: 3)
                                        )
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.navy)
                                } else {
                                    Circle()
                                        .fill(Color.navy)
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.gold, lineWidth: 4)
                                        )
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 16)
                Button(action: {
                    timerActive = false
                    if let selected = selected {
                        onSelection(selected)
                    }
                }) {
                    Text("Continue")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(selected != nil ? Color.gold : Color.gray.opacity(0.5))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selected != nil ? Color.gold : Color.gray.opacity(0.5), lineWidth: 2)
                        )
                }
                .disabled(selected == nil)
                .padding(.horizontal, 32)
                .padding(.top, 16)
            }
            Spacer()
        }
        .background(Color.navy)
        .onAppear {
            timerActive = true
            timerProgress = 0
            startTimer()
        }
        .onDisappear {
            timerActive = false
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            if !timerActive { timer.invalidate(); return }
            if timerProgress < 1.0 {
                timerProgress += timerInterval / timerDuration
            } else {
                timerProgress = 1.0
                timer.invalidate()
                timerActive = false
                // If user hasn't selected, randomly pick for them
                if selected == nil {
                    selected = Bool.random() ? .bat : .bowl
                }
                // If a selection is made, call onSelection(selected)
                if let selected = selected {
                    onSelection(selected)
                }
            }
        }
    }
}

// Helper for computer's random bat/bowl after losing toss
func computerRandomBatBowlChoice() -> BatBowlChoiceScreen.Choice {
    return Bool.random() ? .bat : .bowl
}

struct LoseTossScreen: View {
    let topBar: AnyView
    let goHome: () -> Void
    var onBack: () -> Void
    var onTimerEnd: (() -> Void)? = nil
    @State private var timerProgress: Double = 0
    @State private var timerActive: Bool = true
    let timerDuration: Double = 5.0
    let timerInterval: Double = 0.05

    var body: some View {
        VStack(spacing: 0) {
            topBar
            Rectangle()
                .fill(Color.gold)
                .frame(height: 1)
            // Back to Home button
            HStack {
                Button(action: goHome) {
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
            .padding(.vertical, 18)
            .background(Color.navy.opacity(0.85))
            // Header
            ZStack(alignment: .top) {
                Image("gameMessageBg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                Text("LOSE TOSS")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 24)
            }
            // Large gap below header
            Spacer().frame(height: 80)
            // Timer and waiting text
            VStack(spacing: 16) {
                TimerHourglassView(progress: min(timerProgress, 1.0))
                    .frame(width: 90, height: 90)
                Text("Waiting...")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text("Opponent is deciding to bat or bowl. Please wait for your turn.")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            Spacer()
        }
        .background(Color.navy)
        .onAppear {
            timerActive = true
            timerProgress = 0
            startTimer()
        }
        .onDisappear {
            timerActive = false
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            if !timerActive { timer.invalidate(); return }
            if timerProgress < 1.0 {
                timerProgress += timerInterval / timerDuration
            } else {
                timerProgress = 1.0
                timer.invalidate()
                timerActive = false
                onTimerEnd?()
            }
        }
    }
}

// Wrapper to pass initialBatter to GameView
struct GameViewWrapper: View {
    let initialBatter: InitialBatterType
    var body: some View {
        GameView(initialBatter: initialBatter)
    }
} 
