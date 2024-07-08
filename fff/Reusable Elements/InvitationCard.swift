//
//  InvitationCard.swift
//  fff
//
//  Created by Filipe on 08.07.24.
//

import SwiftUI

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

#Preview {
    InvitationCard()
}
