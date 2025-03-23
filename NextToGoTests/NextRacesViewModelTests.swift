//
//  NextRacesViewModelTests.swift
//  NextToGoTests
//
//  Created by Jigar Thakkar on 24/3/2025.
//

import Testing
@testable import NextToGo
import Foundation
import Combine

private class TestBundleClass { }

// Helper class to capture @Published values
class PublishedCapture<T> {
    var values: [T] = []
    var cancellables: Set<AnyCancellable> = []
    
    init(_ publisher: Published<T>.Publisher) {
        publisher
            .sink { [weak self] value in
                self?.values.append(value)
            }
            .store(in: &cancellables)
    }
}

@Suite("NextRacesViewModel Races Tests")
struct NextRacesViewModelTests {
    let viewModel = NextRacesViewModel(nextRaces: MockRaceProvier())

    func
    
    
    @Test("Races updates after fetch")
    func testFetchUpdatesRaces() async throws {
        let viewModel = NextRacesViewModel(nextRaces: MockRaceProvier(), numerOfRacesToShow: 3)
        let capture = PublishedCapture(viewModel.$races)
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        let updatedRaces = capture.values.last!
        print(updatedRaces)
        #expect(updatedRaces.count <= 3, "Races should not exceed numerOfRacesToShow")
    }
    
    @Test
    func toggleCategory() {
        #expect(viewModel.selectedCategories == Set(RaceCategory.allCases))
        viewModel.toggleCategory(.greyhound)
        #expect(viewModel.selectedCategories == Set(RaceCategory.allCases.filter({ $0 != .greyhound })))
        viewModel.toggleCategory(.harness)
        viewModel.toggleCategory(.horse)
        #expect(viewModel.selectedCategories == [])
    }
}

struct MockRaceProvier: NextRacesProvider {
    func fetchNext(races: Int) async throws -> RaceResponse {
        let bundle = Bundle(for: TestBundleClass.self)
        let jsonURL = bundle.url(forResource: "RacesResponse", withExtension: "json")!
        let data = try Data(contentsOf: jsonURL)
        let mockServiceResponse = ServiceResponse(data: data, response: URLResponse())
        let raceResponse = try? mockServiceResponse.parse(RaceResponse.self)
        return raceResponse!
    }
}
