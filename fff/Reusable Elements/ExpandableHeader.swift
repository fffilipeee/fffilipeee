//
//  ExpandableHeader.swift
//  fff
//
//  Created by ffflip on 07/05/24.
//

import SwiftUI

struct ExpandableHeader: View {
    let companyColor: Color
    let logoImage: String?
    let companyName: String
    let periodWorking: String
    let monthsWorking: String
    let role: String
    let description: String

    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [AppColors.cellTop, AppColors.backgroundColor]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(height: isExpanded ? 80 : 72)
                    .shadow(color: isExpanded ? .clear : AppColors.shadow, radius: 1.5, y: 3)
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: 1.0), trigger: isExpanded)
                
                HStack {
                    Image(logoImage ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: isExpanded ? 40 : 15)
                        .clipShape(Circle())
                        .padding(.leading, 15)
                        .overlay {
                            Circle()
                                .frame(width: isExpanded ? 40 : 15)
                                .padding(.leading, 15)
                                .foregroundColor(companyColor)
                                .opacity(isExpanded &&  logoImage != nil ? 0 : 1)
                        }
                    
                    VStack(alignment: .leading) {
                        Text(role)
                            .font(.subheadline)
                            .bold()
                        Text(companyName)
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
            
            Text(description)
                .opacity(isExpanded ? 1 : 0)
                .frame(height: isExpanded ? nil : 0, alignment: .top)
                .font(.footnote)
                .padding(.horizontal, 30)
                .clipped()
        }
        .padding(.bottom, isExpanded ? 30 : 1 )
    }
}
