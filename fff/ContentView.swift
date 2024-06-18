//
//  ContentView.swift
//  fff
//
//  Created by Filipe Barbosa Nunes on 28.04.24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            WorkView()
                .tabItem {
                    Label("Work", systemImage: "bag.circle")
                }
                .tag(0)

            StudyView()
                .tabItem {
                    Label("Study", systemImage: "pencil.tip.crop.circle")
                }
                .tag(1)
            
            AccomplishmentView()
                .tabItem {
                    Label("Highlights", systemImage: "staroflife.circle.fill")
                }
                .tag(2)
        }
        .accentColor(selectedColor())
    }

    private func selectedColor() -> Color {
        switch selectedTab {
        case 0: // Work
            return .blue
        case 1: // Study
            return .green
        case 2: // Highlights
            return .yellow
        default:
            return .blue
        }
    }
}

// MARK: - Views

struct WorkView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var lastScrollOffset: CGFloat = 0
    @State private var resetColorTimer: AnyCancellable?
    @State private var currentColor: Color = AppColors.mediumGray
    @State private var useDefaultColor: Bool = false
    let animationDuration: Double = 0.1
    let horizontalSpacing: Int = 5
    
    let colors: [Color] = [.blue, .green, .black, .red, .yellow]
    
    var body: some View {
        ScrollView {
            VStack {
                // Used for tracking the scroll position and change apple logo color
                GeometryReader { geometry in
                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                           value: geometry.frame(in: .named("scrollView")).minY)
                }
                .frame(height: 0)
                .id("headerGeometry")
                
                // Top Header
                VStack {
                    VStack {
                        // Header Profile
//                        Circle()
//                            .foregroundStyle(AppColors.mediumGray)
//                            .frame(width: 100)
//                            .padding()
//                        Text("Filipe Barbosa Nunes")
//                        HStack {
//                            Text("iOS Developer")
//                                .foregroundStyle(AppColors.mediumGray)
//                            Image(systemName: "apple.logo")
//                                .imageScale(.small)
//                                .foregroundStyle(useDefaultColor ? AppColors.mediumGray : currentColor)
//                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                                    startPoint: .bottom,
                                    endPoint: .top)
                                )
                                .frame(width: 15, height: 150)
                                .zIndex(1)
                                .offset(y: -200)
                            InvitationCard()
                        }
                        
                        // Companies Experience
                        ExpandableHeader(
                            companyColor: .green,
                            logoImage: "toralarmLogo",
                            companyName: "TorAlarm",
                            periodWorking: "Present",
                            monthsWorking: "Oct 2022",
                            role: "iOS Developer"
                        )
                        .padding(.top)
                        
                        ExpandableHeader(
                            companyColor: .red,
                            companyName: "CI&T",
                            periodWorking: "3 mos",
                            monthsWorking: "Apr 2022\nJul 2022",
                            role: "iOS Developer"
                        )
                        
                        ExpandableHeader(
                            companyColor: Color(hex: "#c10e0e"),
                            companyName: "MatchUp Influencer",
                            periodWorking: "4 yrs 9 mos",
                            monthsWorking: "Aug 2017\nApr 2022",
                            role: "Director of Brand Stategy"
                        )
                        
                        ExpandableHeader(
                            companyColor: .black,
                            companyName: "pontobarraGAME",
                            periodWorking: "3 yrs, 4 mos",
                            monthsWorking: "Oct 2014\nOct 2018",
                            role: "Co-creator"
                        )
                        
                        ExpandableHeader(
                            companyColor: .blue,
                            companyName: "Instituto Alfa e Beto",
                            periodWorking: "4 months",
                            monthsWorking: "Nov 2015\nFeb 2016",
                            role: "Game Developer Intern"
                        )
                    }
                }
            }
            .padding()
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                print("value = \(value)")
                let offsetY = max(0, value)
                if scrollOffset != offsetY {
                    scrollOffset = offsetY
                    useDefaultColor = false
                    updateColorForOffset()
                    resetScrollTimer()
                }
            }
        }
        .coordinateSpace(name: "scrollView")
        .background(AppColors.backgroundColor)
    }
    
    struct FFFColors: View {
        var body: some View {
            HStack(spacing: 2) {
                Image(systemName: "apple.logo")
                    .imageScale(.small)
                    .foregroundStyle(.blue)
                Image(systemName: "apple.logo")
                    .imageScale(.small)
                    .foregroundStyle(.green)
                Image(systemName: "apple.logo")
                    .imageScale(.small)
                    .foregroundStyle(AppColors.mediumGray)
                Image(systemName: "apple.logo")
                    .imageScale(.small)
                    .foregroundStyle(.red)
                Image(systemName: "apple.logo")
                    .imageScale(.small)
                    .foregroundStyle(.yellow)
            }
        }
    }
    
    // MARK: - Updating Apple Logo colors
    
    func updateColorForOffset() {
        let index = min(colors.count - 1, max(0, Int(abs(scrollOffset / 15)) % colors.count))
        let newColor = colors[index]
        withAnimation(.easeInOut(duration: animationDuration)) {
            currentColor = newColor
        }
    }
    
    private func resetScrollTimer() {
        resetColorTimer?.cancel()
        resetColorTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect().sink { _ in
            if self.lastScrollOffset == self.scrollOffset {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    self.useDefaultColor = true
                }
            }
            self.lastScrollOffset = self.scrollOffset
        }
    }
}

struct StudyView: View {
    var body: some View {
        Text("Here goes the study experience ")
    }
}

struct AccomplishmentView: View {
    var body: some View {
        Text("Here goes the accomplishments ")
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        print("\(value)")
        value = nextValue()
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
