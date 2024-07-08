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
    }
}

struct Dot: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct DottedBackground: View {
    var dotSize: CGFloat = 2
    var spacing: CGFloat = 25
    
    var body: some View {
        GeometryReader { geometry in
            let columns = Int(geometry.size.width / (dotSize + spacing)) + 1
            let rows = Int(geometry.size.height / (dotSize + spacing)) + 1

            VStack(spacing: spacing) {
                ForEach(0..<rows, id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(0..<columns, id: \.self) { column in
                            Dot()
                                .frame(width: dotSize, height: dotSize)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}

struct InvitationCard: View {
    let sideSize: CGFloat = 200
    @Environment(\.colorScheme) var colorScheme
    @State private var isDefaultImage: Bool = true
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppColors.backgroundColor)
                .ignoresSafeArea(.all)
            
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black.opacity(0.1))
                    .frame(width: 45, height: 15)
                    .padding(.top, 15)
                    .zIndex(1)
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppColors.cellTop)
                        .frame(width: sideSize, height: sideSize * 1.4)
                        .shadow(color: .black.opacity(0.1), radius: 8.5, y: 10)
                        .overlay {
                            VStack(spacing: 0) {
                                ZStack {
                                    Circle()
                                        .fill(AppColors.mediumGray)
                                        .frame(width: 120)
                                        .padding(.vertical, 20)
                                        .offset(y: -12)
                                        .overlay {
                                            // Avatar Pic
                                            Image(isDefaultImage ? "avatarPhoto" : "avatarIllustration")
                                                 .resizable()
                                                 .scaledToFill()
                                                 .scaleEffect(1.3)
                                                 .clipShape(Circle())
                                                 .onTapGesture { isDefaultImage.toggle() }
                                        }
                                }
                                .padding(.top)
                                        
                                
                                Text("Filipe Barbosa Nunes")
                                Text("iOS Developer")
                                    .foregroundStyle(AppColors.mediumGray)
                                Image(systemName: "apple.logo")
                                    .imageScale(.large)
                                    .foregroundStyle(AppColors.mediumGray)
                                    .padding(.top, 5)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(AppColors.mediumGray)
                                .frame(width: sideSize, height: sideSize * 1.4)
                                .offset(y: 2)
                        }
                }
            }
        }
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
