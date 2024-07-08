//
//  Untitled.swift
//  fff
//
//  Created by Filipe on 08.07.24.
//

import SwiftUI

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

struct Dot: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}
