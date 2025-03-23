//
//  RaceSummary.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

struct RaceSummary: Decodable, Identifiable {
    let id: String
    let raceName: String
    let raceNumber: Int
    let meetingId: String
    let meetingName: String
    let category: RaceCategory
    let advertisedStart: AdvertisedStart
    let raceForm: RaceForm
    let venueId: String
    let venueName: String
    let venueState: String
    let venueCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingId = "meeting_id"
        case meetingName = "meeting_name"
        case category = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueId = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
}

struct AdvertisedStart: Codable {
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case seconds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let seconds = try container.decode(Int.self, forKey: .seconds)
        self.date = Date(timeIntervalSince1970: TimeInterval(seconds))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let seconds = Int(date.timeIntervalSince1970)
        try container.encode(seconds, forKey: .seconds)
    }
}
