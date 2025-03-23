//
//  NextToGoTests.swift
//  NextToGoTests
//
//  Created by Jigar Thakkar on 20/3/2025.
//

import Testing
@testable import NextToGo
import Foundation

private class TestBundleClass { }

struct ServiceResponseTests {
    @Test
    func JSONParsing() async throws {
        let bundle = Bundle(for: TestBundleClass.self)
        if let jsonURL = bundle.url(forResource: "RacesResponse", withExtension: "json") {
            let data = try Data(contentsOf: jsonURL)
            let mockServiceResponse = ServiceResponse(data: data, response: URLResponse())
            let raceResponse = try? mockServiceResponse.parse(RaceResponse.self)
            #expect(raceResponse?.status == 200)
        } else {
            print("JSON file not found in bundle")
        }
    }
}
