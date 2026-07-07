import SwiftUI

enum Theme {
    static let background = Color(red: 0.106, green: 0.055, blue: 0.047)
    static let accent = Color(red: 0.769, green: 0.259, blue: 0.227)
    static let accent2 = Color(red: 0.247, green: 0.655, blue: 0.839)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
