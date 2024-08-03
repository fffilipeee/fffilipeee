//
//  AchievementCard.swift
//  fff
//
//  Created by ffflip on 08/05/24.
//

import SwiftUI

struct AchievementCard: View {
    var title: String
    var image: String
    var text: String
    let sideSize: CGFloat = 160
    
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
            DetailModal(
                title: title,
                image: image,
                text: text
            )
        }
    }
}

struct DetailModal: View {
    var title: String
    var image: String
    var text: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: 320, height: 180)
                .padding()
            Text(text)
            
            Spacer()
        }
        .padding()
    }
}

struct AchievementCarousel: View {
    var achievementCards = [MockedAchievementContentInfo.mock1,
                        MockedAchievementContentInfo.mock2,
                        MockedAchievementContentInfo.mock3]
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        let cardWidth: CGFloat = 160 * 1.3
        let spacing: CGFloat = 20
        let totalWidth = cardWidth + spacing

        VStack(spacing: spacing) {
            ForEach(0..<achievementCards.count, id: \.self) { index in
                AchievementCard(
                    title: achievementCards[index].title,
                    image: achievementCards[index].image,
                    text: achievementCards[index].text
                )
            }
        }
    }
}

struct AchievementContent {
    let title: String
    let image: String
    let text: String
}

struct MockedAchievementContentInfo {
    static let mock1 = AchievementContent(
        title: "1 Game with over 1M+ Downloads on Google Play",
        image: "mock1",
        text: """
    In 2015, ./GAME was created as an indie game project with me and a friend from the university (also my husband nowadays 😄). We created a game called Natan Jump, that was an endless runner then adapted into a meme context that happened in Brazil by the same time called "Run Jessica Run".
    Catapulted by the reach of the meme, the game also got a lot of attention, being also used as a meme in multiple blogs and social media content in different Facebook pages mainly, and within 3 weeks it reached over 1 million downloads. This was a very interesting happy and learning experience, which then influenced our next career steps.
    We continued developing other smaller games in the following year (12 in total), 3 other ones reached over 100k downloads, including one partnership with a brazilian youtuber (Lipão Games).
    As a consequence of that, in 2017 we started working with an Influencer Marketing agency to work with marketing campaigns with internet creators until parting ways and coming back to the development world in 2022, mine specifically, in iOS.
    """
    )
    
    static  let mock2 = AchievementContent(
        title: "2nd Highest GPA on B.S. Computer Sciente degree within 2016's 1st semester",
        image: "mock2",
        text: """
        In 2016, when receiving my Bacherlor's Degree certificate I was surprised to be the 2nd highest GPA among the other students graduating with me.
        Even though I personally don't believe this score fully represents the journey of completing the degree, it was a good feeling of recognition for all the time and effort put to complete it. During the university I also participated as a research assistant in some projects, so I was happy on how much I was able to learn overall.
        """
    )
    
    static let mock3 = AchievementContent(
        title: "1 Year of scholarship in U.C. Davis to study Computer Science",
        image: "mock2",
        text: """
            In 2012 Brazil had a program called Science Without Borders where students could apply to study in an abroad university if meeting requirements such as GPA and a proven English (at least 80 in TOEFL).
            I was fortunate to be qualified for it and in 2013 I was studying at University of California, Davis (commonly called UC Davis). During that time I was continuing to study Computer Science major and also participating in chairs focused on UI and UX, as well as participating as a research assistant in a C++ project called D.A.N.C.E. that was focused on connecting a 3D model figure to the signals sent by the iPad on the Lemur app (a music software). The final focus was to move the 3D figure as you change the sliders and items in the app (such as sliders), so the final objective was that as the music is being mixed, the figure would be moving with it.
        """
    )
}

#Preview {
    AchievementCarousel()
}
