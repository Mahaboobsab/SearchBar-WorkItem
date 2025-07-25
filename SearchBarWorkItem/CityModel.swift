//
//  CItyModel.swift
//  SearchBarWorkItem
//
//  Created by Alkit Gupta on 25/07/25.
//

import Foundation

// MARK: - WelcomeElement
struct CityModel: Codable {
    let name: String
    let lat, lon: Double
    let country: String
    let state: String?
    let localNames: LocalNames?

    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state
        case localNames = "local_names"
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let en: String
}

