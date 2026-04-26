import SwiftUI

struct InsightsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var moodEntryStore: MoodEntryStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Summary Cards
                    summarySection

                    // Weekly Mood Calendar
                    weeklyCalendarSection

                    // Mood Distribution
                    moodDistributionSection

                    // Moon Phase Correlation
                    moonPhaseCorrelationSection
                }
                .padding()
            }
            .background(themeManager.colors.background)
            .navigationTitle("Insights")
        }
    }

    private var summarySection: some View {
        HStack(spacing: 16) {
            SummaryCard(
                title: "Total Entries",
                value: "\(moodEntryStore.entries.count)",
                icon: "list.bullet",
                color: themeManager.colors.primary
            )

            SummaryCard(
                title: "This Week",
                value: "\(moodEntryStore.entriesForThisWeek().count)",
                icon: "calendar",
                color: themeManager.colors.secondary
            )

            SummaryCard(
                title: "Avg Energy",
                value: averageEnergy,
                icon: "bolt.fill",
                color: themeManager.colors.accent
            )
        }
    }

    private var averageEnergy: String {
        let entries = moodEntryStore.entriesForThisWeek()
        guard !entries.isEmpty else { return "-" }
        let avg = Double(entries.reduce(0) { $0 + $1.energyLevel }) / Double(entries.count)
        return String(format: "%.1f", avg)
    }

    private var weeklyCalendarSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This Week")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            HStack(spacing: 8) {
                ForEach(weeklyDays, id: \.self) { day in
                    VStack(spacing: 4) {
                        Text(dayAbbreviation(day))
                            .font(.caption2)
                            .foregroundColor(themeManager.colors.textSecondary)

                        Circle()
                            .fill(entryColor(for: day))
                            .frame(width: 32, height: 32)
                            .overlay(
                                Text("\(calendarDay(day))")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(themeManager.colors.secondaryBackground)
            .cornerRadius(16)
        }
    }

    private var moodDistributionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Mood Distribution")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            VStack(spacing: 8) {
                ForEach(QuickMood.allCases, id: \.rawValue) { mood in
                    HStack {
                        Text(mood.emoji)
                            .font(.title3)
                        Text(mood.name)
                            .font(.subheadline)
                            .foregroundColor(themeManager.colors.textPrimary)

                        Spacer()

                        let count = moodCount(mood)
                        Text("\(count)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(themeManager.colors.primary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background(themeManager.colors.secondaryBackground)
            .cornerRadius(16)
        }
    }

    private var moonPhaseCorrelationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Moon & Mood")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            VStack(spacing: 8) {
                ForEach(MoonPhase.allCases.prefix(4), id: \.rawValue) { phase in
                    let avgMood = averageMoodForPhase(phase)
                    HStack {
                        Text(phase.emoji)
                            .font(.title3)
                        Text(phase.rawValue)
                            .font(.subheadline)
                            .foregroundColor(themeManager.colors.textPrimary)
                        Spacer()
                        if avgMood != nil {
                            Text(avgMoodForDisplay(avgMood))
                                .font(.caption)
                                .foregroundColor(themeManager.colors.accent)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background(themeManager.colors.secondaryBackground)
            .cornerRadius(16)
        }
    }

    private var weeklyDays: [Date] {
        let calendar = Calendar.current
        let today = Date()
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: -6 + $0, to: today) }
    }

    private func dayAbbreviation(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return String(formatter.string(from: date).prefix(1))
    }

    private func calendarDay(_ date: Date) -> String {
        let calendar = Calendar.current
        return "\(calendar.component(.day, from: date))"
    }

    private func entryColor(for date: Date) -> Color {
        let calendar = Calendar.current
        let hasEntry = moodEntryStore.entries.contains { calendar.isDate($0.date, inSameDayAs: date) }
        return hasEntry ? themeManager.colors.primary : themeManager.colors.textSecondary.opacity(0.3)
    }

    private func moodCount(_ mood: QuickMood) -> Int {
        moodEntryStore.entries.filter { $0.quickMood == mood }.count
    }

    private func averageMoodForPhase(_ phase: MoonPhase) -> Double? {
        let entries = moodEntryStore.entries.filter { $0.moonPhase == phase }
        guard !entries.isEmpty else { return nil }
        return Double(entries.reduce(0) { $0 + $1.quickMood.rawValue }) / Double(entries.count)
    }

    private func avgMoodForDisplay(_ avg: Double?) -> String {
        guard let avg = avg else { return "No data" }
        return String(format: "%.1f avg", avg)
    }
}

struct SummaryCard: View {
    @EnvironmentObject var themeManager: ThemeManager
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(themeManager.colors.textPrimary)

            Text(title)
                .font(.caption)
                .foregroundColor(themeManager.colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(themeManager.colors.secondaryBackground)
        .cornerRadius(12)
    }
}

#Preview {
    InsightsView()
        .environmentObject(ThemeManager())
        .environmentObject(MoodEntryStore())
}