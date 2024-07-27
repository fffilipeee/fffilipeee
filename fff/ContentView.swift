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
