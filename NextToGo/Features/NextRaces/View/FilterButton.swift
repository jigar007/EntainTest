//
//  FilterButton.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 24/3/2025.
//

import SwiftUI

struct FilterButton: View {
    let category: RaceCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.displayName)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
        .accessibilityLabel("\(category.displayName) filter")
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    FilterButton(category: .horse, isSelected: false, action: {})
}
