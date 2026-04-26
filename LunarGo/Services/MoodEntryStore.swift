import Foundation
import Combine

class MoodEntryStore: ObservableObject {
    @Published var entries: [MoodEntry] = []
    @Published var manifestations: [Manifestation] = []
    @Published var savedAffirmations: [SavedAffirmation] = []

    private let entriesKey = "mood_entries"
    private let manifestationsKey = "manifestations"
    private let affirmationsKey = "saved_affirmations"

    init() {
        loadEntries()
        loadManifestations()
        loadAffirmations()
    }

    // MARK: - Mood Entries

    func addEntry(_ entry: MoodEntry) {
        entries.insert(entry, at: 0)
        saveEntries()
    }

    func entriesForThisWeek() -> [MoodEntry] {
        let calendar = Calendar.current
        let now = Date()
        guard let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) else { return [] }
        return entries.filter { $0.date >= weekAgo }
    }

    func entriesForThisMonth() -> [MoodEntry] {
        let calendar = Calendar.current
        let now = Date()
        guard let monthAgo = calendar.date(byAdding: .month, value: -1, to: now) else { return [] }
        return entries.filter { $0.date >= monthAgo }
    }

    private func loadEntries() {
        guard let data = UserDefaults.standard.data(forKey: entriesKey),
              let decoded = try? JSONDecoder().decode([MoodEntry].self, from: data) else {
            return
        }
        entries = decoded
    }

    private func saveEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: entriesKey)
        }
    }

    // MARK: - Manifestations

    func addManifestation(_ manifestation: Manifestation) {
        manifestations.insert(manifestation, at: 0)
        saveManifestations()
    }

    func markAchieved(_ id: UUID) {
        if let index = manifestations.firstIndex(where: { $0.id == id }) {
            manifestations[index].isAchieved = true
            manifestations[index].achievedAt = Date()
            saveManifestations()
        }
    }

    func deleteManifestation(_ id: UUID) {
        manifestations.removeAll { $0.id == id }
        saveManifestations()
    }

    private func loadManifestations() {
        guard let data = UserDefaults.standard.data(forKey: manifestationsKey),
              let decoded = try? JSONDecoder().decode([Manifestation].self, from: data) else {
            return
        }
        manifestations = decoded
    }

    private func saveManifestations() {
        if let encoded = try? JSONEncoder().encode(manifestations) {
            UserDefaults.standard.set(encoded, forKey: manifestationsKey)
        }
    }

    // MARK: - Affirmations

    func saveAffirmation(_ text: String) {
        let affirmation = SavedAffirmation(text: text)
        savedAffirmations.insert(affirmation, at: 0)
        saveAffirmations()
    }

    private func loadAffirmations() {
        guard let data = UserDefaults.standard.data(forKey: affirmationsKey),
              let decoded = try? JSONDecoder().decode([SavedAffirmation].self, from: data) else {
            return
        }
        savedAffirmations = decoded
    }

    private func saveAffirmations() {
        if let encoded = try? JSONEncoder().encode(savedAffirmations) {
            UserDefaults.standard.set(encoded, forKey: affirmationsKey)
        }
    }
}