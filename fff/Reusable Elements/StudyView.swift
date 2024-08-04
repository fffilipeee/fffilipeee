//
//  StudyView.swift
//  fff
//
//  Created by Filipe on 27.07.24.
//

import SwiftUI

// MARK: - Views

struct StudyView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var studyExperiences: [StudyExperience] = []
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "pencil.tip.crop.circle")
                Text("Story time")
            }
            .foregroundStyle(AppColors.mediumGray)
            .font(.largeTitle)
            .padding(.top, 64)
            
            ForEach(studyExperiences) { experience in
                if experience.id == "1" {
                    StudyText(text: experience.text)
                } else {
                    StudyExpandableSection(title: experience.title,
                                           text: experience.text,
                                           image: nil)
                }
            }
        }
        .onAppear {
            viewModel.loadStudyExperience { experiences in
                if let experiences = experiences {
                    self.studyExperiences = experiences
                }
            }
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
