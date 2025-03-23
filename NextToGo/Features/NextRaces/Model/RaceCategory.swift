//
//  RaceCategory.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 23/3/2025.
//

import Foundation

enum RaceCategory: String, Codable, CaseIterable, Identifiable {
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .greyhound: return "Greyhound"
        case .harness: return "Harness"
        case .horse: return "Horse"
        }
    }
}
