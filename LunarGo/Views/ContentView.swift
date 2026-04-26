import SwiftUI

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedTab: Tab = .home

    enum Tab: Int {
        case home = 0
        case manifest = 1
        case insights = 2
        case profile = 3
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "moon.fill")
                }
                .tag(Tab.home)

            ManifestView()
                .tabItem {
                    Label("Manifest", systemImage: "sparkles")
                }
                .tag(Tab.manifest)

            InsightsView()
                .tabItem {
                    Label("Insights", systemImage: "chart.bar.fill")
                }
                .tag(Tab.insights)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(Tab.profile)
        }
        .tint(themeManager.colors.primary)
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
        .environmentObject(MoonPhaseManager())
        .environmentObject(MoodEntryStore())
}