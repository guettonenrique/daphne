import SwiftUI

/// Minimalist Monochromatic Dark Design System (Blacks, Grays, Whites)
enum DaphneTheme {
    // MARK: - Surfaces
    static let windowBackground = Color(red: 7/255, green: 7/255, blue: 7/255)     // #070707
    static let sidebarBackground = Color(red: 17/255, green: 17/255, blue: 17/255) // #111111
    static let cardBackground = Color(red: 33/255, green: 33/255, blue: 33/255)    // #212121
    static let cardSelected = Color(red: 45/255, green: 45/255, blue: 45/255)      // #2D2D2D

    // MARK: - Selected Card Accent
    static let green = Color(red: 0.0, green: 0.90, blue: 0.46) // #00E575 (Vibrant Green)

    // MARK: - Borders
    static let borderActive = green.opacity(0.6) // Green glow on selected card

    // MARK: - Typography Colors
    static let textPrimary = Color.white.opacity(0.95)
    static let textSecondary = Color.white.opacity(0.60)
    static let textMuted = Color.white.opacity(0.35)
}

// MARK: - View Modifiers for Daphne Blocks
struct CardModifier: ViewModifier {
    var isSelected: Bool = false

    func body(content: Content) -> some View {
        content
            .background(isSelected ? DaphneTheme.cardSelected : DaphneTheme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? DaphneTheme.borderActive : Color.clear, lineWidth: 1)
            )
    }
}

extension View {
    func card(isSelected: Bool = false) -> some View {
        modifier(CardModifier(isSelected: isSelected))
    }
}
