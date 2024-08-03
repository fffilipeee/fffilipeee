//
//  AccomplishmentView.swift
//  fff
//
//  Created by Filipe on 27.07.24.
//

import SwiftUI

struct AccomplishmentView: View {
    var body: some View {
        ZStack {
            DottedBackground()
                .ignoresSafeArea(.all)
            AchievementCarousel()
        }
    }
}

#Preview {
    AccomplishmentView()
}
