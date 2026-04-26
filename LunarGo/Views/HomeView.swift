import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var moonPhaseManager: MoonPhaseManager
    @EnvironmentObject var moodEntryStore: MoodEntryStore

    @State private var showingMoodSheet = false
    @State private var selectedMood: QuickMood?
    @State private var cosmicCardMood: String = "✨"

    private let affirmations = [
        "You are a cosmic being having a human experience 🌌",
        "The universe conspires in your favor ✨",
        "Your energy is magnetic and powerful 💫",
        "Today is full of infinite possibilities 🌙",
        "You are exactly where you need to be 🔮",
        "Your vibes attract your tribe 💜",
        "Trust the timing of your journey ⏳",
        "You are worthy of all your dreams ✨"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Moon Phase Header
                moonPhaseHeader

                // Daily Cosmic Card
                cosmicCard

                // Quick Mood Check-in
                moodCheckInSection

                // Today's Affirmation
                affirmationSection

                // Recent Entries
                recentEntriesSection
            }
            .padding()
        }
        .background(themeManager.colors.background)
        .sheet(isPresented: $showingMoodSheet) {
            MoodCheckInSheet(selectedMood: $selectedMood)
        }
    }

    private var moonPhaseHeader: some View {
        VStack(spacing: 8) {
            Text(moonPhaseManager.currentPhase.emoji)
                .font(.system(size: 60))

            Text(moonPhaseManager.currentPhase.rawValue)
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            HStack(spacing: 16) {
                Label("\(Int(moonPhaseManager.illumination * 100))%", systemImage: "circle.lefthalf.filled")
                    .font(.caption)
                    .foregroundColor(themeManager.colors.accent)

                Text("•")
                    .foregroundColor(themeManager.colors.textSecondary)

                Text("\(moonPhaseManager.energyLevel) Energy")
                    .font(.caption)
                    .foregroundColor(themeManager.colors.primary)
            }

            Text(moonPhaseManager.currentPhase.description)
                .font(.caption)
                .foregroundColor(themeManager.colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(themeManager.colors.secondaryBackground)
        .cornerRadius(16)
    }

    private var cosmicCard: some View {
        VStack(spacing: 12) {
            Text("Your Cosmic Card")
                .font(.subheadline)
                .foregroundColor(themeManager.colors.textSecondary)

            ZStack {
                LinearGradient(
                    colors: [themeManager.colors.primary, themeManager.colors.secondary],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                VStack(spacing: 16) {
                    Text(cosmicCardMood)
                        .font(.system(size: 50))

                    Text(affirmations.randomElement() ?? affirmations[0])
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    HStack(spacing: 4) {
                        ForEach(0..<4, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Image(systemName: "star")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                }
            }
            .frame(height: 220)
            .cornerRadius(20)
            .onTapGesture {
                cosmicCardMood = ["💫", "✨", "🌙", "🔥", "🌌", "⭐"][Int.random(in: 0...5)]
            }

            HStack {
                Button(action: { }) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .tint(.white)

                Button(action: { }) {
                    Label("Save", systemImage: "heart")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .tint(.white)
            }
        }
    }

    private var moodCheckInSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How are you feeling?")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            HStack(spacing: 12) {
                ForEach(QuickMood.allCases, id: \.rawValue) { mood in
                    Button(action: {
                        selectedMood = mood
                        showingMoodSheet = true
                    }) {
                        VStack(spacing: 6) {
                            Text(mood.emoji)
                                .font(.title)
                            Text(mood.name)
                                .font(.caption2)
                                .foregroundColor(themeManager.colors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(themeManager.colors.secondaryBackground)
                        .cornerRadius(12)
                    }
                }
            }
        }
        .padding()
        .background(themeManager.colors.secondaryBackground.opacity(0.5))
        .cornerRadius(16)
    }

    private var affirmationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Daily Affirmation")
                    .font(.headline)
                    .foregroundColor(themeManager.colors.textPrimary)

                Spacer()

                Button(action: { }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.caption)
                }
            }

            Text(affirmations.randomElement() ?? affirmations[0])
                .font(.body)
                .foregroundColor(themeManager.colors.textPrimary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(themeManager.colors.accent.opacity(0.2))
                .cornerRadius(12)
        }
        .padding()
        .background(themeManager.colors.secondaryBackground.opacity(0.3))
        .cornerRadius(16)
    }

    private var recentEntriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Entries")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            if moodEntryStore.entries.isEmpty {
                Text("No entries yet. Start your cosmic journey!")
                    .font(.subheadline)
                    .foregroundColor(themeManager.colors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(moodEntryStore.entries.prefix(3)) { entry in
                    HStack {
                        Text(entry.quickMood.emoji)
                            .font(.title2)
                        VStack(alignment: .leading) {
                            Text(entry.quickMood.name)
                                .font(.subheadline)
                                .foregroundColor(themeManager.colors.textPrimary)
                            Text(entry.date, style: .relative)
                                .font(.caption)
                                .foregroundColor(themeManager.colors.textSecondary)
                        }
                        Spacer()
                        Text(entry.moonPhase.emoji)
                    }
                    .padding()
                    .background(themeManager.colors.secondaryBackground)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(themeManager.colors.secondaryBackground.opacity(0.3))
        .cornerRadius(16)
    }
}

struct MoodCheckInSheet: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var moonPhaseManager: MoonPhaseManager
    @EnvironmentObject var moodEntryStore: MoodEntryStore
    @Environment(\.dismiss) var dismiss

    @Binding var selectedMood: QuickMood?
    @State private var energyLevel: Int = 3
    @State private var journalText: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if let mood = selectedMood {
                    Text(mood.emoji)
                        .font(.system(size: 80))

                    Text("I'm feeling \(mood.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Energy Level")
                        .font(.headline)

                    HStack(spacing: 8) {
                        ForEach(1...5, id: \.self) { level in
                            Button(action: { energyLevel = level }) {
                                Image(systemName: level <= energyLevel ? "star.fill" : "star")
                                    .font(.title2)
                                    .foregroundColor(themeManager.colors.accent)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Quick Journal (optional)")
                        .font(.headline)

                    TextField("How's your energy today?", text: $journalText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(3...6)
                }

                Button(action: saveEntry) {
                    Text("Save Entry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(themeManager.colors.primary)
                        .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .background(themeManager.colors.background)
            .navigationTitle("Log Mood")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    private func saveEntry() {
        guard let mood = selectedMood else { return }
        let entry = MoodEntry(
            quickMood: mood,
            energyLevel: energyLevel,
            journalText: journalText.isEmpty ? nil : journalText,
            moonPhase: moonPhaseManager.currentPhase
        )
        moodEntryStore.addEntry(entry)
        dismiss()
    }
}

#Preview {
    HomeView()
        .environmentObject(ThemeManager())
        .environmentObject(MoonPhaseManager())
        .environmentObject(MoodEntryStore())
}