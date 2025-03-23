//
//  NextRacesService.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

protocol NextRaces {
    func fetchNext(races: Int) async throws -> RaceResponse
}

class NextRacesService: NextRaces {
    public func fetchNext(races: Int) async throws -> RaceResponse {
        try await NextRacesRequest(races: races).perform().parse(RaceResponse.self)
    }
}

struct NextRacesRequest: ServiceRequest {
    let races: Int
    let endpoint: ServiceEndpoints = .racing
    let session: URLSession = .shared
    let httpMethod: URLRequest.RequestHttpMethod = .get
    var queryParameters: NSDictionary? {
        ["method": "nextraces",
         "count": races]
    }
}
