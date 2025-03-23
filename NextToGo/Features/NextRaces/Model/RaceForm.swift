//
//  RaceForm.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

struct RaceForm: Decodable {
    let distance: Int
    let distanceType: DistanceType
    let distanceTypeId: String
    let trackCondition: TrackCondition?
    let trackConditionId: String?
    let weather: Weather?
    let weatherId: String?
    let raceComment: String
    let generated: Int
    let silkBaseUrl: String
    let raceCommentAlternative: String
    
    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeId = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionId = "track_condition_id"
        case weather
        case weatherId = "weather_id"
        case raceComment = "race_comment"
        case additionalData = "additional_data"
        case generated
        case silkBaseUrl = "silk_base_url"
        case raceCommentAlternative = "race_comment_alternative"
    }
    
    // Custom decoding for additional_data (JSON string)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        distance = try container.decode(Int.self, forKey: .distance)
        distanceType = try container.decode(DistanceType.self, forKey: .distanceType)
        distanceTypeId = try container.decode(String.self, forKey: .distanceTypeId)
        trackCondition = try container.decodeIfPresent(TrackCondition.self, forKey: .trackCondition)
        trackConditionId = try container.decodeIfPresent(String.self, forKey: .trackConditionId)
        weather = try container.decodeIfPresent(Weather.self, forKey: .weather)
        weatherId = try container.decodeIfPresent(String.self, forKey: .weatherId)
        raceComment = try container.decode(String.self, forKey: .raceComment)
        generated = try container.decode(Int.self, forKey: .generated)
        silkBaseUrl = try container.decode(String.self, forKey: .silkBaseUrl)
        raceCommentAlternative = try container.decode(String.self, forKey: .raceCommentAlternative)
    }
}

struct DistanceType: Decodable {
    let id: String
    let name: String
    let shortName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
    }
}

struct Weather: Decodable {
    let id: String
    let name: String
    let shortName: String
    let iconUri: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
        case iconUri = "icon_uri"
    }
}

struct AdditionalData: Decodable {
    let revealedRaceInfo: RevealedRaceInfo
    
    enum CodingKeys: String, CodingKey {
        case revealedRaceInfo = "revealed_race_info"
    }
}

struct TrackCondition: Decodable {
    let id: String
    let name: String
    let shortName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
    }
}
