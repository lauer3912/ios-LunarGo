import SwiftUI

struct ManifestView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var moodEntryStore: MoodEntryStore

    @State private var showingAddSheet = false
    @State private var newGoalText = ""
    @State private var selectedImage: UIImage?

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Streak Counter
                    streakSection

                    // Manifestation Board
                    boardSection
                }
                .padding()
            }
            .background(themeManager.colors.background)
            .navigationTitle("Manifest")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddManifestationSheet(isPresented: $showingAddSheet)
            }
        }
    }

    private var streakSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Manifestation Streak")
                    .font(.subheadline)
                    .foregroundColor(themeManager.colors.textSecondary)

                HStack(alignment: .bottom, spacing: 4) {
                    Text("\(streakCount)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(themeManager.colors.primary)

                    Text("days")
                        .font(.caption)
                        .foregroundColor(themeManager.colors.textSecondary)
                        .padding(.bottom, 8)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Active Intentions")
                    .font(.subheadline)
                    .foregroundColor(themeManager.colors.textSecondary)

                Text("\(moodEntryStore.manifestations.filter { !$0.isAchieved }.count)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.colors.accent)
            }
        }
        .padding()
        .background(themeManager.colors.secondaryBackground)
        .cornerRadius(16)
    }

    private var boardSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Vision Board")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            if moodEntryStore.manifestations.isEmpty {
                emptyBoardView
            } else {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(moodEntryStore.manifestations) { manifest in
                        ManifestTileView(manifestation: manifest)
                    }
                }
            }
        }
    }

    private var emptyBoardView: some View {
        VStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 50))
                .foregroundColor(themeManager.colors.primary.opacity(0.5))

            Text("Your board is empty")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            Text("Add your first intention to start manifesting")
                .font(.subheadline)
                .foregroundColor(themeManager.colors.textSecondary)
                .multilineTextAlignment(.center)

            Button(action: { showingAddSheet = true }) {
                Label("Add Intention", systemImage: "plus")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(themeManager.colors.primary)
                    .cornerRadius(12)
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity)
        .background(themeManager.colors.secondaryBackground.opacity(0.5))
        .cornerRadius(20)
    }

    private var streakCount: Int {
        // Calculate based on consecutive days with manifestations
        0
    }
}

struct ManifestTileView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var moodEntryStore: MoodEntryStore
    let manifestation: Manifestation

    @State private var showingDetail = false

    var body: some View {
        ZStack {
            if let imageData = manifestation.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                LinearGradient(
                    colors: [themeManager.colors.primary.opacity(0.6), themeManager.colors.secondary.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Text(manifestation.goalText)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(8)
            }

            VStack {
                HStack {
                    Spacer()
                    if manifestation.isAchieved {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .padding(8)
                    }
                }
                Spacer()
            }

            if manifestation.isAchieved {
                Color.black.opacity(0.3)
            }
        }
        .frame(height: 150)
        .cornerRadius(16)
        .onTapGesture {
            showingDetail = true
        }
        .sheet(isPresented: $showingDetail) {
            ManifestDetailSheet(manifestation: manifestation, isPresented: $showingDetail)
        }
    }
}

struct ManifestDetailSheet: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var moodEntryStore: MoodEntryStore
    let manifestation: Manifestation
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let imageData = manifestation.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(16)
                }

                Text(manifestation.goalText)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.colors.textPrimary)
                    .multilineTextAlignment(.center)

                VStack(spacing: 8) {
                    Text("Created: \(manifestation.createdAt.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(themeManager.colors.textSecondary)

                    if manifestation.isAchieved, let achievedAt = manifestation.achievedAt {
                        Text("Achieved: \(achievedAt.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }

                HStack(spacing: 16) {
                    if !manifestation.isAchieved {
                        Button(action: markAchieved) {
                            Label("Mark Achieved", systemImage: "checkmark")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                    }

                    Button(action: deleteItem) {
                        Label("Delete", systemImage: "trash")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .padding()
            .background(themeManager.colors.background)
            .navigationTitle("Intention")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { isPresented = false }
                }
            }
        }
    }

    private func markAchieved() {
        moodEntryStore.markAchieved(manifestation.id)
        isPresented = false
    }

    private func deleteItem() {
        moodEntryStore.deleteManifestation(manifestation.id)
        isPresented = false
    }
}

struct AddManifestationSheet: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var moodEntryStore: MoodEntryStore
    @Binding var isPresented: Bool

    @State private var goalText = ""
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("What's your intention?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.colors.textPrimary)

                TextField("e.g., I am confident and successful", text: $goalText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...5)
                    .padding()

                Button(action: selectPhoto) {
                    VStack(spacing: 12) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .cornerRadius(12)
                        } else {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.largeTitle)
                                .foregroundColor(themeManager.colors.primary)

                            Text("Add Image (Optional)")
                                .font(.subheadline)
                                .foregroundColor(themeManager.colors.textSecondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(themeManager.colors.secondaryBackground)
                    .cornerRadius(16)
                }

                Button(action: save) {
                    Text("Add to Board")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(goalText.isEmpty ? themeManager.colors.primary.opacity(0.5) : themeManager.colors.primary)
                        .cornerRadius(12)
                }
                .disabled(goalText.isEmpty)

                Spacer()
            }
            .padding()
            .background(themeManager.colors.background)
            .navigationTitle("New Intention")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
            }
        }
    }

    private func selectPhoto() {
        // Photo picker would go here
    }

    private func save() {
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        let manifestation = Manifestation(
            imageData: imageData,
            goalText: goalText
        )
        moodEntryStore.addManifestation(manifestation)
        isPresented = false
    }
}

#Preview {
    ManifestView()
        .environmentObject(ThemeManager())
        .environmentObject(MoodEntryStore())
}