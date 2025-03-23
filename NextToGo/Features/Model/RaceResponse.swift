//
//  RaceResponse.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

struct RaceResponse: Decodable {
    let status: Int
    let data: RaceData
    let message: String
}

struct RaceData: Decodable {
    let nextToGoIds: [String]
    let raceSummaries: [String: RaceSummary]
    
    enum CodingKeys: String, CodingKey {
        case nextToGoIds = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}
