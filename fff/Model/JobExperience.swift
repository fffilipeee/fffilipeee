//
//  JobExperience.swift
//  fff
//
//  Created by Filipe on 17.07.24.
//

import SwiftUI

struct JobExperience: Identifiable, Codable {
    var id: UUID
    let companyColor: String
    let logoImage: String?
    let companyName: String
    let periodWorking: String
    let monthsWorking: String
    let role: String
    let description: String
}

