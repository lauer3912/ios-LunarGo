import XCTest
@testable import LunarGo

final class LunarGoTests: XCTestCase {

    func testMoonPhaseCalculation() throws {
        let manager = MoonPhaseManager()
        let phase = manager.currentPhase
        XCTAssertNotNil(phase)
        XCTAssertGreaterThanOrEqual(MoonPhase.allCases.count, 8)
    }

    func testMoodEntryCreation() throws {
        let entry = MoodEntry(
            quickMood: .happy,
            energyLevel: 4,
            journalText: "Feeling great today!",
            moonPhase: MoonPhase.fullMoon
        )
        XCTAssertEqual(entry.quickMood, .happy)
        XCTAssertEqual(entry.energyLevel, 4)
        XCTAssertEqual(entry.moonPhase, .fullMoon)
    }

    func testThemeManager() throws {
        let themeManager = ThemeManager()
        XCTAssertNotNil(themeManager.currentTheme)
        XCTAssertEqual(themeManager.currentTheme, .cosmicDark)
    }

    func testZodiacSigns() throws {
        XCTAssertEqual(ZodiacSign.allCases.count, 12)
        XCTAssertEqual(ZodiacSign.leo.symbol, "♌")
        XCTAssertEqual(ZodiacSign.leo.element, "Fire")
    }

    func testQuickMoodEnum() throws {
        XCTAssertEqual(QuickMood.allCases.count, 5)
        XCTAssertEqual(QuickMood.happy.emoji, "🌙")
        XCTAssertEqual(QuickMood.energetic.name, "Energetic")
    }

    func testManifestationCreation() throws {
        let manifest = Manifestation(
            goalText: "I will travel the world"
        )
        XCTAssertEqual(manifest.goalText, "I will travel the world")
        XCTAssertFalse(manifest.isAchieved)
    }

    func testMoodEntryStore() throws {
        let store = MoodEntryStore()
        let initialCount = store.entries.count
        let entry = MoodEntry(quickMood: .calm, energyLevel: 3)
        store.addEntry(entry)
        XCTAssertEqual(store.entries.count, initialCount + 1)
    }
}