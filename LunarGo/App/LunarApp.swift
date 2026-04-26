import SwiftUI

@main
struct LunarApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var moonPhaseManager = MoonPhaseManager()
    @StateObject private var moodEntryStore = MoodEntryStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(moonPhaseManager)
                .environmentObject(moodEntryStore)
        }
    }
}