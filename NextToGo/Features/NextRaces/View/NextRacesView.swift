//
//  ContentView.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 20/3/2025.
//

import SwiftUI

struct NextRacesView: View {
    @StateObject private var viewModel: NextRacesViewModel
    
    // Use a factory init to inject the provider
    init(nextRaces: NextRacesProvider = NextRacesService()) {
        self._viewModel = StateObject(wrappedValue: NextRacesViewModel(nextRaces: nextRaces))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(RaceCategory.allCases) { category in
                            FilterButton(
                                category: category,
                                isSelected: viewModel.selectedCategories.contains(category),
                                action: { viewModel.toggleCategory(category) }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                List(viewModel.races) { race in
                    RaceRow(race: race, viewModel: viewModel)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Race \(race.raceNumber) at \(race.meetingName))")
                }
                .listStyle(.plain)
            }
            .navigationTitle("Next to Go")
        }
        .dynamicTypeSize(.medium ... .xxxLarge) // Support Dynamic Type
    }
}

#Preview {
    NextRacesView()
}
