//
//  NextRacesService.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

protocol NextRacesProvider {
    func fetchNext(races: Int) async throws -> RaceResponse
}

// Further related methods can be added here
class NextRacesService: NextRacesProvider {
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
