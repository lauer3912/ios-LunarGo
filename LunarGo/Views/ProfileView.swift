import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var userProfile = UserProfileManager()

    @State private var showingZodiacPicker = false
    @State private var showingThemePicker = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    profileHeader

                    // Subscription Card
                    subscriptionCard

                    // Settings
                    settingsSection

                    // About
                    aboutSection
                }
                .padding()
            }
            .background(themeManager.colors.background)
            .navigationTitle("Profile")
        }
        .sheet(isPresented: $showingZodiacPicker) {
            ZodiacPickerSheet(selectedSign: $userProfile.zodiacSign, isPresented: $showingZodiacPicker)
        }
        .sheet(isPresented: $showingThemePicker) {
            ThemePickerSheet(isPresented: $showingThemePicker)
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 16) {
            // Avatar
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [themeManager.colors.primary, themeManager.colors.secondary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)

                Text(userProfile.zodiacSign.symbol)
                    .font(.system(size: 36))
                    .foregroundColor(.white)
            }

            VStack(spacing: 4) {
                Text("Cosmic Traveler")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.colors.textPrimary)

                Button(action: { showingZodiacPicker = true }) {
                    HStack {
                        Text(userProfile.zodiacSign.name)
                        Image(systemName: "chevron.right")
                    }
                    .font(.subheadline)
                    .foregroundColor(themeManager.colors.primary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(themeManager.colors.secondaryBackground)
        .cornerRadius(20)
    }

    private var subscriptionCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "crown.fill")
                    .foregroundColor(themeManager.colors.accent)
                Text("Premium")
                    .font(.headline)
                    .foregroundColor(themeManager.colors.textPrimary)
            }

            Text("Unlock unlimited cosmic cards, AI personalization, and export features")
                .font(.caption)
                .foregroundColor(themeManager.colors.textSecondary)

            Button(action: { }) {
                Text("Upgrade - $4.99/month")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [themeManager.colors.primary, themeManager.colors.secondary],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(themeManager.colors.secondaryBackground)
        .cornerRadius(16)
    }

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Settings")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            VStack(spacing: 0) {
                // Theme Toggle
                SettingsRow(
                    icon: "paintpalette.fill",
                    title: "App Theme",
                    trailing: {
                        Button(action: { showingThemePicker = true }) {
                            HStack {
                                Text(themeManager.themeDisplayName)
                                    .font(.caption)
                                    .foregroundColor(themeManager.colors.primary)
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(themeManager.colors.textSecondary)
                            }
                        }
                    }
                )

                Divider()
                    .padding(.leading, 56)

                // Notifications
                SettingsRow(
                    icon: "bell.fill",
                    title: "Daily Reminder",
                    trailing: {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(themeManager.colors.textSecondary)
                    }
                )

                Divider()
                    .padding(.leading, 56)

                // Data Export
                SettingsRow(
                    icon: "square.and.arrow.up",
                    title: "Export Data",
                    trailing: {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(themeManager.colors.textSecondary)
                    }
                )
            }
            .background(themeManager.colors.secondaryBackground)
            .cornerRadius(12)
        }
    }

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About")
                .font(.headline)
                .foregroundColor(themeManager.colors.textPrimary)

            VStack(spacing: 0) {
                SettingsRow(
                    icon: "doc.text",
                    title: "Privacy Policy",
                    trailing: {
                        Image(systemName: "arrow.up.right")
                            .font(.caption)
                            .foregroundColor(themeManager.colors.textSecondary)
                    }
                )

                Divider()
                    .padding(.leading, 56)

                SettingsRow(
                    icon: "star",
                    title: "Rate App",
                    trailing: {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(themeManager.colors.textSecondary)
                    }
                )

                Divider()
                    .padding(.leading, 56)

                SettingsRow(
                    icon: "envelope",
                    title: "Contact",
                    trailing: {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(themeManager.colors.textSecondary)
                    }
                )
            }
            .background(themeManager.colors.secondaryBackground)
            .cornerRadius(12)

            Text("LunarGo v1.0.0")
                .font(.caption)
                .foregroundColor(themeManager.colors.textSecondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 8)
        }
    }
}

struct SettingsRow<Trailing: View>: View {
    @EnvironmentObject var themeManager: ThemeManager
    let icon: String
    let title: String
    @ViewBuilder let trailing: () -> Trailing

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(themeManager.colors.primary)
                .frame(width: 24)

            Text(title)
                .font(.body)
                .foregroundColor(themeManager.colors.textPrimary)

            Spacer()

            trailing()
        }
        .padding()
    }
}

struct ZodiacPickerSheet: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var selectedSign: ZodiacSign
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            List {
                ForEach(ZodiacSign.allCases, id: \.rawValue) { sign in
                    Button(action: {
                        selectedSign = sign
                        isPresented = false
                    }) {
                        HStack {
                            Text(sign.symbol)
                                .font(.title2)
                                .frame(width: 40)

                            VStack(alignment: .leading) {
                                Text(sign.name)
                                    .font(.headline)
                                    .foregroundColor(themeManager.colors.textPrimary)
                                Text(sign.element)
                                    .font(.caption)
                                    .foregroundColor(themeManager.colors.textSecondary)
                            }

                            Spacer()

                            if selectedSign == sign {
                                Image(systemName: "checkmark")
                                    .foregroundColor(themeManager.colors.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Your Sign")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
            }
        }
    }
}

class UserProfileManager: ObservableObject {
    @Published var zodiacSign: ZodiacSign {
        didSet { save() }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "user_profile"),
           let profile = try? JSONDecoder().decode(UserProfileData.self, from: data) {
            self.zodiacSign = profile.zodiacSign
        } else {
            self.zodiacSign = .leo
        }
    }

    private func save() {
        let profile = UserProfileData(zodiacSign: zodiacSign)
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: "user_profile")
        }
    }
}

private struct UserProfileData: Codable {
    var zodiacSign: ZodiacSign
}

struct ThemePickerSheet: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            List {
                ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                    Button(action: {
                        themeManager.currentTheme = theme
                        isPresented = false
                    }) {
                        HStack {
                            ThemePreviewCard(theme: theme)
                                .frame(width: 60, height: 40)

                            VStack(alignment: .leading) {
                                Text(theme.rawValue)
                                    .font(.headline)
                                    .foregroundColor(themeManager.colors.textPrimary)
                                Text(themeDescription(theme))
                                    .font(.caption)
                                    .foregroundColor(themeManager.colors.textSecondary)
                            }

                            Spacer()

                            if themeManager.currentTheme == theme {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(themeManager.colors.primary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Choose Your Vibe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { isPresented = false }
                }
            }
        }
    }

    private func themeDescription(_ theme: AppTheme) -> String {
        switch theme {
        case .cosmicDark: return "Purple cosmos, mysterious vibes"
        case .neonGlow: return "Cyberpunk neon, futuristic"
        case .dreamPastel: return "Soft pink, cute & sweet"
        case .midnightBlue: return "Deep blue, calm & cool"
        case .forestSpirit: return "Nature green, earthy"
        case .sunsetWarm: return "Orange fire, warm energy"
        case .auroraLight: return "Light mode, aurora colors"
        case .shadowNoir: return "Minimalist black & white"
        }
    }
}

struct ThemePreviewCard: View {
    let theme: AppTheme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(themeBackground(theme))

            RoundedRectangle(cornerRadius: 6)
                .stroke(themePrimary(theme), lineWidth: 2)

            Circle()
                .fill(themePrimary(theme).opacity(0.6))
                .frame(width: 20, height: 20)
        }
    }

    private func themeBackground(_ theme: AppTheme) -> Color {
        switch theme {
        case .cosmicDark: return Color(hex: "0D0B1E")
        case .neonGlow: return Color(hex: "0A0A0A")
        case .dreamPastel: return Color(hex: "FFF5F7")
        case .midnightBlue: return Color(hex: "0F1629")
        case .forestSpirit: return Color(hex: "0D1A0D")
        case .sunsetWarm: return Color(hex: "1A0F0A")
        case .auroraLight: return Color(hex: "F0F4FF")
        case .shadowNoir: return Color(hex: "0A0A0A")
        }
    }

    private func themePrimary(_ theme: AppTheme) -> Color {
        switch theme {
        case .cosmicDark: return Color(hex: "9B5DE5")
        case .neonGlow: return Color(hex: "00FF88")
        case .dreamPastel: return Color(hex: "FF9ECD")
        case .midnightBlue: return Color(hex: "4A90D9")
        case .forestSpirit: return Color(hex: "4ADE80")
        case .sunsetWarm: return Color(hex: "FF6B35")
        case .auroraLight: return Color(hex: "7C3AED")
        case .shadowNoir: return Color.white
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ThemeManager())
}