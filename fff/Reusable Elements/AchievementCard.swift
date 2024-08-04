//
//  AchievementCard.swift
//  fff
//
//  Created by ffflip on 08/05/24.
//

import SwiftUI

struct AchievementCard: View {
    var title: String
    var image: String
    var text: String
    let sideSize: CGFloat = 160
    
    @State private var isModalPresented = false
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topTrailing) {
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [AppColors.cellTop, AppColors.backgroundColor]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: sideSize * 1.3, height: sideSize)
                        .shadow(color: AppColors.shadow, radius: 1.5, y: 3)
                        .overlay {
                            VStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text(title)
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .padding()
                            }
                        }
                }
            }
        }
        .onTapGesture {
            isModalPresented = true
        }
        .sheet(isPresented: $isModalPresented) {
            DetailModal(
                title: title,
                image: image,
                text: text
            )
        }
    }
}

struct DetailModal: View {
    var title: String
    var image: String
    var text: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: 320, height: 180)
                .padding()
            Text(text)
            
            Spacer()
        }
        .padding()
    }
}

struct AchievementCarousel: View {
    @StateObject private var viewModel = ViewModel()
    @State private var highlights: [Highlight] = []
    
    var body: some View {
        let cardWidth: CGFloat = 160 * 1.3
        let spacing: CGFloat = 20
        let totalWidth = cardWidth + spacing
        
        VStack(spacing: spacing) {
            ForEach(highlights) { highlight in
                AchievementCard(
                    title: highlight.title,
                    image: highlight.image,
                    text: highlight.text
                )
            }
        }
        .onAppear {
            viewModel.loadHighlights { highlights in
                if let highlights = highlights {
                    self.highlights = highlights
                }
            }
        }
    }
}

#Preview {
    AchievementCarousel()
}
