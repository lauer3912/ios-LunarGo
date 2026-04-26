# LunarGo - Operating Instructions

## Overview

LunarGo is an astrology and mood tracking app for teens. Users log their daily mood, track moon phases, and create manifestation boards.

## User Flow

### First Launch
1. App opens to Home screen with Daily Cosmic Card
2. User selects zodiac sign (optional, can skip)
3. User can enable notifications for daily reminders

### Daily Use - Mood Check-in
1. Open app -> Home screen
2. Tap one of 5 mood emojis (Exhausted/Calm/Happy/Energetic/Anxious)
3. Optionally log: energy level (1-5 stars), journal text, sleep quality, stress level
4. Mood entry saved with current moon phase automatically

### Daily Use - View Moon Phase
1. Home screen shows current moon phase at top
2. Moon emoji + phase name + illumination percentage
3. Energy level indicator (High/Building/Active/Releasing)
4. Brief description of today's cosmic energy

### Manifestation Board
1. Navigate to Manifest tab
2. Tap + to add new intention
3. Enter goal text + optional image
4. Track intentions -> mark as achieved

### Insights
1. Navigate to Insights tab
2. View weekly mood calendar
3. See mood distribution chart
4. View moon-mood correlation

### Change Theme
1. Navigate to Profile tab
2. Tap "App Theme" setting
3. Choose from 8 themes:
   - Cosmic Dark (default) -- Purple cosmos
   - Neon Glow -- Cyberpunk neon
   - Dream Pastel -- Soft pink
   - Midnight Blue -- Deep blue
   - Forest Spirit -- Nature green
   - Sunset Warm -- Orange fire
   - Aurora Light -- Light mode
   - Shadow Noir -- Minimalist B&W

## Testing Screenshot Steps

1. Sync code to MacinCloud
2. Generate project: `~/tools/xcodegen/bin/xcodegen generate`
3. Run app on simulator
4. Navigate through all tabs
5. Take screenshots using Simulator (Cmd+S)
6. Verify sizes match App Store requirements

## Common Issues

**App won't build:**
- Check CODE_SIGNING_ALLOWED is YES for Release config
- Verify DEVELOPMENT_TEAM is set to 9L6N2ZF26B

**Icons show as generic:**
- Ensure AppIcon Contents.json has 19 entries with filenames
- Generate icons from 1024x1024 source using ios-app-icon-generator skill

**Theme not persisting:**
- Check UserDefaults key "app_theme" is being set correctly
- Ensure AppTheme enum has rawValue that matches stored string