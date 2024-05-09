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

#Preview {
    AchievementCard()
}
