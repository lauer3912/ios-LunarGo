import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    var quickMood: QuickMood
    var energyLevel: Int
    var journalText: String?
    var sleepQuality: Int?
    var stressLevel: Int?
    var moonPhase: MoonPhase

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        quickMood: QuickMood,
        energyLevel: Int = 3,
        journalText: String? = nil,
        sleepQuality: Int? = nil,
        stressLevel: Int? = nil,
        moonPhase: MoonPhase = MoonPhaseManager().currentPhase
    ) {
        self.id = id
        self.date = date
        self.quickMood = quickMood
        self.energyLevel = energyLevel
        self.journalText = journalText
        self.sleepQuality = sleepQuality
        self.stressLevel = stressLevel
        self.moonPhase = moonPhase
    }
}

enum QuickMood: Int, CaseIterable, Codable {
    case exhausted = 0    // 💫
    case calm = 1         // ✨
    case happy = 2        // 🌙
    case energetic = 3    // 🔥
    case anxious = 4      // 😴

    var emoji: String {
        switch self {
        case .exhausted: return "💫"
        case .calm: return "✨"
        case .happy: return "🌙"
        case .energetic: return "🔥"
        case .anxious: return "😴"
        }
    }

    var name: String {
        switch self {
        case .exhausted: return "Exhausted"
        case .calm: return "Calm"
        case .happy: return "Happy"
        case .energetic: return "Energetic"
        case .anxious: return "Anxious"
        }
    }
}

struct Manifestation: Identifiable, Codable {
    let id: UUID
    var imageData: Data?
    var goalText: String
    let createdAt: Date
    var achievedAt: Date?
    var isAchieved: Bool

    init(
        id: UUID = UUID(),
        imageData: Data? = nil,
        goalText: String,
        createdAt: Date = Date(),
        achievedAt: Date? = nil,
        isAchieved: Bool = false
    ) {
        self.id = id
        self.imageData = imageData
        self.goalText = goalText
        self.createdAt = createdAt
        self.achievedAt = achievedAt
        self.isAchieved = isAchieved
    }
}

struct SavedAffirmation: Identifiable, Codable {
    let id: UUID
    let text: String
    let savedAt: Date

    init(id: UUID = UUID(), text: String, savedAt: Date = Date()) {
        self.id = id
        self.text = text
        self.savedAt = savedAt
    }
}

struct UserProfile: Codable {
    var zodiacSign: ZodiacSign
    var theme: AppTheme
    var onboardingComplete: Bool
    let createdAt: Date

    init(
        zodiacSign: ZodiacSign = .leo,
        theme: AppTheme = .cosmicDark,
        onboardingComplete: Bool = false,
        createdAt: Date = Date()
    ) {
        self.zodiacSign = zodiacSign
        self.theme = theme
        self.onboardingComplete = onboardingComplete
        self.createdAt = createdAt
    }
}

enum ZodiacSign: String, CaseIterable, Codable {
    case aries, taurus, gemini, cancer, leo, virgo
    case libra, scorpio, sagittarius, capricorn, aquarius, pisces

    var name: String {
        rawValue.capitalized
    }

    var symbol: String {
        switch self {
        case .aries: return "♈"
        case .taurus: return "♉"
        case .gemini: return "♊"
        case .cancer: return "♋"
        case .leo: return "♌"
        case .virgo: return "♍"
        case .libra: return "♎"
        case .scorpio: return "♏"
        case .sagittarius: return "♐"
        case .capricorn: return "♑"
        case .aquarius: return "♒"
        case .pisces: return "♓"
        }
    }

    var element: String {
        switch self {
        case .aries, .leo, .sagittarius: return "Fire"
        case .taurus, .virgo, .capricorn: return "Earth"
        case .gemini, .libra, .aquarius: return "Air"
        case .cancer, .scorpio, .pisces: return "Water"
        }
    }
}

enum AppTheme: String, Codable, CaseIterable {
    case cosmicDark = "Cosmic Dark"
    case neonGlow = "Neon Glow"
    case dreamPastel = "Dream Pastel"
    case midnightBlue = "Midnight Blue"
    case forestSpirit = "Forest Spirit"
    case sunsetWarm = "Sunset Warm"
    case auroraLight = "Aurora Light"
    case shadowNoir = "Shadow Noir"
}

enum MoonPhase: String, Codable, CaseIterable {
    case newMoon = "New Moon"
    case waxingCrescent = "Waxing Crescent"
    case firstQuarter = "First Quarter"
    case waxingGibbous = "Waxing Gibbous"
    case fullMoon = "Full Moon"
    case waningGibbous = "Waning Gibbous"
    case lastQuarter = "Last Quarter"
    case waningCrescent = "Waning Crescent"

    var emoji: String {
        switch self {
        case .newMoon: return "🌑"
        case .waxingCrescent: return "🌒"
        case .firstQuarter: return "🌓"
        case .waxingGibbous: return "🌔"
        case .fullMoon: return "🌕"
        case .waningGibbous: return "🌖"
        case .lastQuarter: return "🌗"
        case .waningCrescent: return "🌘"
        }
    }

    var energyLevel: String {
        switch self {
        case .newMoon, .fullMoon: return "High"
        case .waxingCrescent, .waxingGibbous: return "Building"
        case .waningCrescent, .waningGibbous: return "Releasing"
        case .firstQuarter, .lastQuarter: return "Active"
        }
    }

    var description: String {
        switch self {
        case .newMoon: return "Perfect for new beginnings and setting intentions"
        case .waxingCrescent: return "Time to take action on your goals"
        case .firstQuarter: return "Face challenges and push forward"
        case .waxingGibbous: return "Refine and adjust your path"
        case .fullMoon: return "Great for manifestations and celebrations"
        case .waningGibbous: return "Express gratitude and release"
        case .lastQuarter: return "Forgive and let go of what no longer serves"
        case .waningCrescent: return "Rest and reflect before the new cycle"
        }
    }
}