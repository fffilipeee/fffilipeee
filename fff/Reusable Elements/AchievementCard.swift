//
//  AchievementCard.swift
//  fff
//
//  Created by ffflip on 08/05/24.
//

import SwiftUI

struct AchievementCard: View {
    let sideSize: CGFloat = 160
    var title: String
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
            DetailModal(title: title)
        }
    }
}

struct DetailModal: View {
    var title: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            Text(title)
            
            Spacer()
        }
        .padding()
    }
}

struct AchievementCarousel: View {
    let achievements = [
        "Computer Science Bachelor's Degree",
        "1 Game with over 1M+ Downloads on Google Play",
        "2nd Highest GPA on B.S. Computer Sciente degree within 2016's 1st semester",
        "1 Year of scholarship in U.C. Davis to study Computer Science"
    ]
    
    @State private var offset: CGFloat = 0
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth: CGFloat = 160 * 1.3
            let spacing: CGFloat = 20
            let totalWidth = cardWidth + spacing

            HStack(spacing: spacing) {
                ForEach(0..<achievements.count * 2, id: \.self) { index in
                    AchievementCard(title: achievements[index % achievements.count])
                }
            }
            .offset(x: offset)
            .onReceive(timer) { _ in
                withAnimation(.smooth) {
                    offset -= 1
                    if abs(offset) >= totalWidth * CGFloat(achievements.count) {
                        offset = 0
                    }
                }
            }
        }
        .frame(height: 160)
    }
}

#Preview {
//    AchievementCard()
//    InvitationCard()
    AchievementCarousel()
}
