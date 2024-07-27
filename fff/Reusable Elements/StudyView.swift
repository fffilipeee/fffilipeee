//
//  StudyView.swift
//  fff
//
//  Created by Filipe on 27.07.24.
//

import SwiftUI

// MARK: - Dummy Texts

let introductionText = """
I have completed my studies in Computer Science in 2016 as a Bachelor's undergraduate. During this period, I was happy to have participated in some cool projects that I'll detail below.
"""

let hortalandiaTitle = "Hortalândia: a game developed for an undergratuate Nutrition thesis"
let hortalandiaText = """
 This project was a combination between different departments: Nutrition, Computer Science, Pedagogy and Music. The idea was to use the game to teach kids in Elementary school on differentiating fruits and vegetables, understand which ones are better for the health, and those concepts being given through a narrative of two siblings that live in a farm.\nFor this one I participated in a big part of the concept, assets creating and programming assistant. It was an interesting project to learn more on working as a team and developing my illustration and programming skills. In a Nutrition Symposium held in the university we also won for Best Presentation for the one created to explain the project.

Technologies used: Processing (programming), Photoshop (art assets)
"""

let APOTitle = "APO Digital: a survey developed with the Architecture department for improving the house usability in Uberlândia"
let APOText = """
In this one I participated for less time, but happened more towards the ending of my major. The design team was already built, so my work was more towards making a project from scratch using Unity.
Technologies used: Unity
"""

let b110Title = "B110: Game development discussion between different indie groups"
let b110Text = """
Different indie game groups from Computer Science group would gather together to discuss implementations and the ideas we were working on. On this one I created together with a friend a group called ./game, in which we used CoronaSDK (now called Solar2D) to create 12 small mobile games in total.
Using the meme culture from Brazil, we had some games that got over 100k installs, and one of them surpassing 1.3 million downloads. A very interesting experiment on releasing different products.
"""

let conclusionText = """
Apart from this projects, I participated in a program called Science Without Borders which was a scholarship to study during a year in an University in another country, and I was accepted at University of California, Davis. In which I could develop my english, programming and user experience skills. This happened in 2013 and was a great addition to my education.

By working also in Marketing for a Canadian company (which also happened because of the games I helped creating), I was able to grap a more tailored view on the user and their experience. That's why iOS for me fits well with my skillset, since it allows me to create interesting visual flow to guide through the apps information, and also has helped me work well with different teams within a company.
"""

// MARK: - Views

struct StudyView: View {
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "pencil.tip.crop.circle")
                Text("Story time")
            }
            .foregroundStyle(AppColors.mediumGray)
            .font(.largeTitle)
            .padding(.top, 64)
            
            Text("My Bachelor's degree")
                .font(.headline)
                .padding(.bottom, 32)
            
            StudyText(text: introductionText)
            
            // Hortalândia
            StudyExpandableSection(title: hortalandiaTitle,
                              text: hortalandiaText,
                              image: "hortalandia_logo")
            
            // MORA Digital
            StudyExpandableSection(title: APOTitle,
                              text: APOText,
                              image: "apodigital_logo")
            
            // B110
            StudyExpandableSection(title: b110Title,
                              text: b110Text,
                              image: nil)
            
            // Conclusion Text
            StudyText(text: conclusionText)
        }
    }
}

struct StudyExpandableSection: View {
    let title: String
    let text: String
    let image: String?
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            StudyTitleText(text: title,
                           isExpanded: $isExpanded,
                           image: self.image)
            if isExpanded {
                StudyText(text: text)
                Button(action: {
                    withAnimation { isExpanded.toggle() }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                        .padding(.bottom, 16)
                }
            } else {
                Button(action: {
                    withAnimation { isExpanded.toggle() }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                        .padding(.bottom, 16)
                }
            }
        }
    }
}

struct StudyTitleText: View {
    let text: String
    let iconSideSize = CGFloat(50)
    @Binding var isExpanded: Bool
    let image: String?
    
    private var firstWord: String {
        let separators: CharacterSet = [" ", ":"]
        let components = text.components(separatedBy: separators)
        return components.first ?? text
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let image = image {
                Image(image)
                    .resizable()
                    .frame(width: iconSideSize, height: iconSideSize)
                    .mask(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: iconSideSize, height: iconSideSize)
                    .overlay {
                        Text(firstWord)
                            .foregroundStyle(.white)
                    }
            }
                
            Text(text)
                .font(.system(size: 13))
                .padding(.vertical, 8)
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .onTapGesture {
                    isExpanded.toggle()
                }
        }
    }
}

struct StudyText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 13))
            .fontWeight(.light)
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
    }
}

// MARK: - Preview
#Preview {
    StudyView()
}
