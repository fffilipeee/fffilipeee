//
//  ViewModel.swift
//  fff
//
//  Created by Filipe on 17.07.24.
//

import Foundation

class ViewModel: ObservableObject {
    func loadCompanyExperience(completion: @escaping ([JobExperience]?) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/fbnunes/fffilipeee/main/fff/JSONs/JobExperience.json") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let experiences = try decoder.decode([JobExperience].self, from: data)
                completion(experiences)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func loadStudyExperience(completion: @escaping ([StudyExperience]?) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/fbnunes/fffilipeee/main/fff/JSONs/StudyExperience.json") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let experiences = try decoder.decode([StudyExperience].self, from: data)
                completion(experiences)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func loadHighlights(completion: @escaping ([Highlight]?) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/fbnunes/fffilipeee/main/fff/JSONs/Highlights.json") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let highlights = try decoder.decode([Highlight].self, from: data)
                completion(highlights)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
