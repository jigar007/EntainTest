//
//  RaceRow.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 24/3/2025.
//

import SwiftUI

struct RaceRow: View {
    let race: RaceSummary
    @ObservedObject var viewModel: NextRacesViewModel
    @State private var countdown: String = ""
    @State private var timer: Timer?
    
    var body: some View {
        HStack {
            Image(categoryIcon(for: race.category))
                .foregroundColor(.gray)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading) {
                Text("\(race.meetingName) - Race \(race.raceNumber)")
                    .font(.headline)
                Text("Starts in: \(countdown)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
        .onAppear {
            countdown = viewModel.countdownString(for: race)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                countdown = viewModel.countdownString(for: race)
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func categoryIcon(for category: RaceCategory) -> ImageResource {
        switch category {
        case .greyhound: return .greyhoundSymbols
        case .harness: return .harnessSymbols
        case .horse: return .horseSymbols
        }
    }
}
