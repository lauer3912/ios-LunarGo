import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme {
        didSet {
            saveTheme()
        }
    }

    init() {
        if let saved = UserDefaults.standard.string(forKey: "app_theme"),
           let theme = AppTheme(rawValue: saved) {
            self.currentTheme = theme
        } else {
            self.currentTheme = .cosmicDark // Default for teens
        }
    }

    var colors: AppColors {
        switch currentTheme {
        case .cosmicDark:
            return AppColors(
                background: Color(hex: "0D0B1E"),
                secondaryBackground: Color(hex: "1A1730"),
                primary: Color(hex: "9B5DE5"),
                secondary: Color(hex: "F15BB5"),
                accent: Color(hex: "FEE440"),
                textPrimary: .white,
                textSecondary: Color(hex: "A0A0C0"),
                cardGradient: [Color(hex: "9B5DE5"), Color(hex: "F15BB5")]
            )
        case .neonGlow:
            return AppColors(
                background: Color(hex: "0A0A0A"),
                secondaryBackground: Color(hex: "1A1A2E"),
                primary: Color(hex: "00FF88"),
                secondary: Color(hex: "FF00FF"),
                accent: Color(hex: "00FFFF"),
                textPrimary: .white,
                textSecondary: Color(hex: "888888"),
                cardGradient: [Color(hex: "00FF88"), Color(hex: "FF00FF")]
            )
        case .dreamPastel:
            return AppColors(
                background: Color(hex: "FFF5F7"),
                secondaryBackground: Color(hex: "FFE4EC"),
                primary: Color(hex: "FF9ECD"),
                secondary: Color(hex: "A88BEB"),
                accent: Color(hex: "8BE4D0"),
                textPrimary: Color(hex: "4A3F55"),
                textSecondary: Color(hex: "8B7B95"),
                cardGradient: [Color(hex: "FF9ECD"), Color(hex: "A88BEB")]
            )
        case .midnightBlue:
            return AppColors(
                background: Color(hex: "0F1629"),
                secondaryBackground: Color(hex: "1E2A4A"),
                primary: Color(hex: "4A90D9"),
                secondary: Color(hex: "6B5BFF"),
                accent: Color(hex: "50E3C2"),
                textPrimary: .white,
                textSecondary: Color(hex: "8899BB"),
                cardGradient: [Color(hex: "4A90D9"), Color(hex: "6B5BFF")]
            )
        case .forestSpirit:
            return AppColors(
                background: Color(hex: "0D1A0D"),
                secondaryBackground: Color(hex: "1A2E1A"),
                primary: Color(hex: "4ADE80"),
                secondary: Color(hex: "22D3EE"),
                accent: Color(hex: "F59E0B"),
                textPrimary: .white,
                textSecondary: Color(hex: "88AA88"),
                cardGradient: [Color(hex: "4ADE80"), Color(hex: "22D3EE")]
            )
        case .sunsetWarm:
            return AppColors(
                background: Color(hex: "1A0F0A"),
                secondaryBackground: Color(hex: "2E1A14"),
                primary: Color(hex: "FF6B35"),
                secondary: Color(hex: "F7931E"),
                accent: Color(hex: "FFD700"),
                textPrimary: .white,
                textSecondary: Color(hex: "CC9988"),
                cardGradient: [Color(hex: "FF6B35"), Color(hex: "F7931E")]
            )
        case .auroraLight:
            return AppColors(
                background: Color(hex: "F0F4FF"),
                secondaryBackground: Color(hex: "E8F0FF"),
                primary: Color(hex: "7C3AED"),
                secondary: Color(hex: "EC4899"),
                accent: Color(hex: "06B6D4"),
                textPrimary: Color(hex: "1E1B4B"),
                textSecondary: Color(hex: "6B7280"),
                cardGradient: [Color(hex: "7C3AED"), Color(hex: "EC4899")]
            )
        case .shadowNoir:
            return AppColors(
                background: Color(hex: "0A0A0A"),
                secondaryBackground: Color(hex: "151515"),
                primary: Color(hex: "FFFFFF"),
                secondary: Color(hex: "888888"),
                accent: Color(hex: "CCCCCC"),
                textPrimary: .white,
                textSecondary: Color(hex: "666666"),
                cardGradient: [Color(hex: "333333"), Color(hex: "666666")]
            )
        }
    }

    var themeDisplayName: String {
        currentTheme.rawValue
    }

    private func saveTheme() {
        UserDefaults.standard.set(currentTheme.rawValue, forKey: "app_theme")
    }

    func toggle() {
        // Cycle through themes for quick switching
        let themes = AppTheme.allCases
        if let currentIndex = themes.firstIndex(of: currentTheme) {
            let nextIndex = (currentIndex + 1) % themes.count
            currentTheme = themes[nextIndex]
        }
    }
}

struct AppColors {
    let background: Color
    let secondaryBackground: Color
    let primary: Color
    let secondary: Color
    let accent: Color
    let textPrimary: Color
    let textSecondary: Color
    let cardGradient: [Color]

    static let dark = AppColors(
        background: Color(hex: "0D0B1E"),
        secondaryBackground: Color(hex: "1A1730"),
        primary: Color(hex: "9B5DE5"),
        secondary: Color(hex: "F15BB5"),
        accent: Color(hex: "FEE440"),
        textPrimary: .white,
        textSecondary: Color(hex: "A0A0C0"),
        cardGradient: [Color(hex: "9B5DE5"), Color(hex: "F15BB5")]
    )

    static let light = AppColors(
        background: Color(hex: "FFF5F7"),
        secondaryBackground: Color(hex: "FFE4EC"),
        primary: Color(hex: "9B5DE5"),
        secondary: Color(hex: "F15BB5"),
        accent: Color(hex: "00BBF9"),
        textPrimary: Color(hex: "2D2A4A"),
        textSecondary: Color(hex: "8B8AA8"),
        cardGradient: [Color(hex: "9B5DE5"), Color(hex: "F15BB5")]
    )
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}