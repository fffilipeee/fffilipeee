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
    let viewModel = ViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            WorkView(viewModel: viewModel)
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
    @ObservedObject var viewModel: ViewModel
    @State private var scrollOffset: CGFloat = 0
    @State private var lastScrollOffset: CGFloat = 0
    @State private var resetColorTimer: AnyCancellable?
    @State private var currentColor: Color = AppColors.mediumGray
    @State private var useDefaultColor: Bool = false
    @State private var experiences: [JobExperience] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    let animationDuration: Double = 0.1
    let horizontalSpacing: Int = 5
    
    let colors: [Color] = [.blue, .green, .black, .red, .yellow]
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                           value: geometry.frame(in: .named("scrollView")).minY)
                }
                .frame(height: 0)
                .id("headerGeometry")
                
                VStack {
                    VStack {
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
                        .padding(.bottom)
                        
                        if isLoading {
                            Text("Loading...")
                                .padding(.top, 100)
                        } else if let errorMessage = errorMessage {
                            Text("Error: \(errorMessage)")
                        } else {
                            ForEach(experiences) { experience in
                                ExpandableHeader(
                                    companyColor: Color(hex: experience.companyColor),
                                    logoImage: experience.logoImage ?? "",
                                    companyName: experience.companyName,
                                    periodWorking: experience.periodWorking,
                                    monthsWorking: experience.monthsWorking,
                                    role: experience.role,
                                    description: experience.description
                                )
                            }
                        }
                    }
                }
            }
            .padding()
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                let offsetY = max(0, value)
                if scrollOffset != offsetY {
                    scrollOffset = offsetY
                    useDefaultColor = false
                    updateColorForOffset()
                    resetScrollTimer()
                }
            }
            .onAppear {
                viewModel.loadCompanyExperience { fetchedExperiences in
                    DispatchQueue.main.async {
                        if let fetchedExperiences = fetchedExperiences {
                            self.experiences = fetchedExperiences
                            self.isLoading = false
                        } else {
                            self.errorMessage = "Failed to load experiences"
                            self.isLoading = false
                        }
                    }
                }
            }
        }
        .coordinateSpace(name: "scrollView")
        .background(AppColors.backgroundColor)
    }
    
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
        Text("Here goes the Study Accomplishments ")
    }
}

struct AccomplishmentView: View {
    var body: some View {
        ZStack {
            DottedBackground()
                .ignoresSafeArea(.all)
            AchievementCarousel()
        }
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
