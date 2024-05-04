//
//  ExperienceText.swift
//  fff
//
//  Created by ffflip on 05/05/24.
//

import SwiftUI

struct ExperienceText: View {
    var body: some View {
        VStack {
            Text("Hello, Test!")
                .font(.subheadline)
            TextDivider()
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")
                .font(.footnote)
                .padding(.horizontal, 30)
            TextDivider()
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")
                .font(.footnote)
                .padding(.horizontal, 30)
            HStack {
                ForEach(0..<5, id: \.self) {_ in
                    Circle()
                        .frame(width: 30)
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 10)
                }
            }
        }

    }
}

#Preview {
    ExperienceText()
}

struct TextDivider: View {
    var body: some View {
        Rectangle()
            .frame(width: 250, height: 1)
            .opacity(0.2)
            .padding(.vertical, 10)
    }
}
