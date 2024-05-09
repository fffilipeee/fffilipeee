//
//  AchievementCard.swift
//  fff
//
//  Created by ffflip on 08/05/24.
//

import SwiftUI

struct AchievementCard: View {
    let sideSize: CGFloat = 160
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppColors.backgroundColor)
                .ignoresSafeArea(.all)
            
            DottedBackground()
                .ignoresSafeArea(.all)
            
            ZStack(alignment: .topTrailing) {
                Circle()
                    .fill(.blue)
                    .frame(width: 45, height: 45)
                    .padding(.trailing, -15)
                    .padding(.top, -15)
                    .zIndex(1)
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [AppColors.cellTop, AppColors.backgroundColor]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: sideSize, height: sideSize)
                        .shadow(color: AppColors.shadow, radius: 1.5, y: 3)
                        .overlay {
                            Text("College Degree\nComputer Science Bachelor's Degree")
                                .padding()
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
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppColors.backgroundColor)
                .ignoresSafeArea(.all)
            
            DottedBackground()
                .ignoresSafeArea(.all)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(width: 10, height: 320)
                    .zIndex(2)
                    .offset(y: -302)
                
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
                                Circle()
                                    .fill(AppColors.mediumGray)
                                    .frame(width: 100)
                                    .padding(.vertical, 20)
                                    .offset(y: -12)
                                    
                            Text("Filipe Barbosa Nunes")
                                Text("iOS Developer")
                                    .foregroundStyle(AppColors.mediumGray)
                                Image(systemName: "apple.logo")
                                    .imageScale(.large)
                                    .offset(y: 30)
                                    .foregroundStyle(AppColors.mediumGray)
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

#Preview {
//    AchievementCard()
    InvitationCard()
}
