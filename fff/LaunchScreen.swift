//
//  LaunchScreen.swift
//  fff
//
//  Created by Filipe on 08.07.24.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(.black)
                    .ignoresSafeArea(.all)
                Image("fff")
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
