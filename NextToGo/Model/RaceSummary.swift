//
//  RaceSummary.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

struct RaceSummary: Decodable {
    let raceId: String
    let raceName: String
    let raceNumber: Int
    let meetingId: String
    let meetingName: String
    let categoryId: String
    let advertisedStart: AdvertisedStart
    let raceForm: RaceForm
    let venueId: String
    let venueName: String
    let venueState: String
    let venueCountry: String
    
    enum CodingKeys: String, CodingKey {
        case raceId = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingId = "meeting_id"
        case meetingName = "meeting_name"
        case categoryId = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueId = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
}

struct AdvertisedStart: Decodable {
    let seconds: Int
}
