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
                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).minY)
                }
                .frame(height: 0)
                
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
                            companyName: "TorAlarm",
                            periodWorking: "Present",
                            monthsWorking: "Oct 2022"
                        )
                        .padding(.top)
                        
                        ExpandableHeader(
                            companyColor: .red,
                            companyName: "CI&T",
                            periodWorking: "3 mos",
                            monthsWorking: "Apr 2022\nJul 2022"
                        )
                        
                        ExpandableHeader(
                            companyColor: Color(hex: "#c10e0e"),
                            companyName: "MatchUp Influencer",
                            periodWorking: "4 yrs 9 mos",
                            monthsWorking: "Aug 2017\nApr 2022"
                        )
                        
                        ExpandableHeader(
                            companyColor: .black,
                            companyName: "pontobarraGAME",
                            periodWorking: "3 yrs, 4 mos",
                            monthsWorking: "Oct 2014\nOct 2018"
                        )
                        
                        ExpandableHeader(
                            companyColor: .blue,
                            companyName: "Instituto Alfa e Beto",
                            periodWorking: "4 months",
                            monthsWorking: "Nov 2015\nFeb 2016"
                        )

                    }
                    

                }
            }
            .padding()
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                if scrollOffset != value {
                    scrollOffset = value
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
        var companyName: String
        var periodWorking: String
        var monthsWorking: String
        
        @State private var isExpanded: Bool = false
        
        var body: some View {
            VStack {
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#f0f0f0"), Constants.backgroundColor.opacity(isExpanded ? 0.2 : 0.9)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(height: isExpanded ? 60 : 52)
                        .shadow(color: isExpanded ? Constants.backgroundColor : Color(hex: "#c3c3c3"), radius: 2, y: 2)
                    
                    HStack {
                        Circle()
                            .frame(width: 20)
                            .padding(.leading, 15)
                            .foregroundColor(companyColor)
                        Text(companyName)
                            .font(.footnote)
                            .bold()
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
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .padding(.trailing, 15)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                
                if isExpanded {
                    Text("Details about \(companyName) where I worked for \(monthsWorking).")
                        .font(.caption2)
                        .padding()
//                        .transition(.push(from: isExpanded ? .bottom : .top))
                        .transition(.asymmetric(insertion: .push(from: .top), removal: .push(from: .bottom)))
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
        value = nextValue()
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
