//
//  ContentView.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 20/3/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var nextToGoIds: [String] = []
    
    var body: some View {
        VStack {
            ForEach($nextToGoIds, id: \.self) {
                Text("\($0)")
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task {
            do {
                let races = try await NextRacesService().fetchNext(races: 2)
                races.data.raceSummaries.forEach {
                    print($0.value.categoryId)
                    nextToGoIds.append($0.value.categoryId)
                }
            } catch {
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
