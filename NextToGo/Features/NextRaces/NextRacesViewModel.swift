//
//  NextRacesViewModel.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 23/3/2025.
//

import Foundation

class NextRacesViewModel: ObservableObject {
    @Published private(set) var races: [RaceSummary] = []
    @Published var selectedCategories: Set<RaceCategory> = Set(RaceCategory.allCases)
    private let raceService: NextRacesProvider
    private var refreshTask: Task<Void, Never>?
    
    private let numerOfRacesToShow: Int
    private let numberOfRacesToFetch: Int
    
    init(nextRaces: NextRacesProvider, numerOfRacesToShow: Int = 5, numberOfRacesToFetch: Int = 30) {
        self.raceService = nextRaces
        self.numerOfRacesToShow = numerOfRacesToShow
        self.numberOfRacesToFetch = numberOfRacesToFetch
        startAutoRefresh()
    }
    
    deinit {
        refreshTask?.cancel()
    }
    
    // MARK: - Public Methods
    
    public func toggleCategory(_ category: RaceCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
        Task { await fetchAndUpdateRaces() }
    }
    
    // Helper to calculate countdown string
    public func countdownString(for race: RaceSummary) -> String {
        let now = Date()
        let startDate = race.advertisedStart.date
        let interval = startDate.timeIntervalSince(now)
        
        if interval <= 0 {
            return "Started"
        }
        
        let minutes = Int(interval / 60)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Private Methods
    private func startAutoRefresh() {
        refreshTask = Task { [weak self] in
            while !Task.isCancelled {
                await self?.fetchAndUpdateRaces()
                try? await Task.sleep(nanoseconds: 5_000_000_000) // Refresh every 5 seconds
            }
        }
    }
       
    private func fetchAndUpdateRaces() async {
        do {
            let response = try await raceService.fetchNext(races: numberOfRacesToFetch)
            let allRaces = response.data.raceSummaries.values
                .sorted { $0.advertisedStart.date < $1.advertisedStart.date }
            
            // Filter races that are not more than 1 minute past start time
            let now = Date()
            let validRaces = allRaces.filter {
                let cutoff = $0.advertisedStart.date.addingTimeInterval(60)
                return now <= cutoff
            }
            
            // Apply category filter
            let filteredRaces: [RaceSummary]
            if selectedCategories.isEmpty {
                filteredRaces = validRaces
            } else {
                filteredRaces = validRaces.filter { race in
                    selectedCategories.contains(race.category)
                }
            }
            // Update races to always show 5
            await updateRaces(with: Array(filteredRaces.prefix(numerOfRacesToShow)))
        } catch {
            print("Error fetching races: \(error)")
        }
    }
    
    @MainActor
    private func updateRaces(with filteredRaces: [RaceSummary]) {
        self.races = filteredRaces
    }
}
