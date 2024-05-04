//
//  ContentView.swift
//  fff
//
//  Created by Filipe Barbosa Nunes on 28.04.24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var lastScrollOffset: CGFloat = 0
    @State private var resetColorTimer: AnyCancellable?
    @State private var currentColor: Color = Color(hex: "#c3c3c3")
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
                        Circle()
                            .foregroundStyle(Color(hex: "#c3c3c3"))
                            .frame(width: 100)
                            .padding()
                        Text("Filipe Barbosa Nunes")
                        HStack {
                            Text("iOS Developer")
                                .foregroundStyle(Color(hex: "#c3c3c3"))
                            Image(systemName: "apple.logo")
                                .imageScale(.small)
                                .foregroundStyle(useDefaultColor ? Color(hex: "#c3c3c3") : currentColor)
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
                            role: "Intern"
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
        .background(Constants.backgroundColor)
    }
    // MARK: - Views
    
    struct ExpandableHeader: View {
        var companyColor: Color
        var logoImage: String?
        var companyName: String
        var periodWorking: String
        var monthsWorking: String
        var role: String
        
        @State private var isExpanded: Bool = false
        
        var body: some View {
            VStack {
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#f0f0f0"), Constants.backgroundColor.opacity(isExpanded ? 0.2 : 0.9)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(height: isExpanded ? 80 : 72)
                        .shadow(color: isExpanded ? Constants.backgroundColor : Color(hex: "#c3c3c3").opacity(0.5), radius: 1.5, y: 3)
                        .sensoryFeedback(.impact(flexibility: .soft, intensity: 1.0), trigger: isExpanded)
                    
                    HStack {
                        Image(logoImage ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: isExpanded ? 40 : 20, height: isExpanded ? 40 : 20)
                            .clipShape(Circle())
                            .padding(.leading, 15)
                            .overlay {
                                Circle()
                                    .frame(width: isExpanded ? 40 : 20)
                                    .padding(.leading, 15)
                                    .foregroundColor(companyColor)
                                    .opacity(isExpanded &&  logoImage != nil ? 0 : 1)
                            }
                        
                        VStack(alignment: .leading) {
                            Text(companyName)
                                .font(.subheadline)
                                .bold()
                            Text(role)
                                .font(.caption2)
                                .opacity(0.4)
                        }
                        .padding(.leading, 5)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(periodWorking)
                                .font(.caption)
                            Text(monthsWorking)
                                .font(.caption2)
                                .opacity(0.4)
                        }
                        .padding(.trailing, 15)
                        
                        // Expand / Collapse icon
                        Image(systemName: "chevron.down")
                            .resizable()
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .opacity(0.4)
                            .frame(width: 10, height: 5)
                            .padding(.trailing, 15)
                        
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                
                if isExpanded {
                    VStack {
//                        Text("Details about \(companyName) where I worked for \(monthsWorking).")
//                            .font(.caption2)
//                            .padding()
//                            .transition(.asymmetric(insertion: .push(from: .top), removal: .push(from: .bottom)))
                        ExperienceText()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, isExpanded ? 30 : 12)
        }
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
                    .foregroundStyle(Color(hex: "#c3c3c3"))
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
