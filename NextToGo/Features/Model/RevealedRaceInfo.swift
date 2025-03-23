//
//  RevealedRaceInfo.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

struct RevealedRaceInfo: Decodable {
    let trackName: String
    let state: String
    let country: String
    let number: Int
    let raceName: String
    let time: String
    let raceClass: String?
    let startType: String
    let prizemonies: Prizemonies
    let localisedPrizemonies: LocalisedPrizemonies
    let railPosition: String
    let trackDirection: String
    let trackSurface: String
    let group: String
    let gait: String
    let trackHomeStraightMetres: Int
    let trackCircumference: Int
    
    enum CodingKeys: String, CodingKey {
        case trackName = "track_name"
        case state
        case country
        case number
        case raceName = "race_name"
        case time
        case raceClass = "class"
        case startType = "start_type"
        case prizemonies
        case localisedPrizemonies = "localised_prizemonies"
        case railPosition = "rail_position"
        case trackDirection = "track_direction"
        case trackSurface = "track_surface"
        case group
        case gait
        case trackHomeStraightMetres = "track_home_straight_metres"
        case trackCircumference = "track_circumference"
    }
}

struct Prizemonies: Decodable {
    let totalValue: Int
    
    enum CodingKeys: String, CodingKey {
        case totalValue = "total_value"
    }
}
struct LocalisedPrizemonies: Decodable {
    let aud: PrizeMoneyDetail
    let nzd: PrizeMoneyDetail

    enum CodingKeys: String, CodingKey {
        case aud = "AUD"
        case nzd = "NZD"
    }
}

struct PrizeMoneyDetail: Decodable {
    let first: Int
    let second: Int
    let third: Int
    let fourth: Int?
    let fifth: Int?
    let totalValue: Int
    
    enum CodingKeys: String, CodingKey {
        case first = "1st"
        case second = "2nd"
        case third = "3rd"
        case fourth = "4th"
        case fifth = "5th"
        case totalValue = "total_value"
    }
}
