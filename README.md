# LunarGo 🌙✨

> Your Cosmic Mood Journal - Astrology & Mood Tracker for Teens

![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![UI](https://img.shields.io/badge/UI-SwiftUI-purple)
![Category](https://img.shields.io/badge/Category-Lifestyle-green)

## About

LunarGo is a mystical mood tracking app designed for Western teens (13-25). Track your emotions, discover cosmic insights based on moon phases, and manifest your dreams with AI-powered daily cosmic cards.

## Features

### 🌙 Daily Cosmic Card
AI-generated mood card based on moon phase and zodiac

### ✨ Moon Phase Tracker
Automatic moon phase calculation with energy levels

### 💫 Mood Check-in
5 quick moods with detailed journaling

### 🎯 Manifestation Board
Create vision boards with intention tiles

### 📊 Insights & Analytics
Weekly/monthly mood reports with moon-mood correlation

### 🎨 8 Personalized Themes
Cosmic Dark / Neon Glow / Dream Pastel / Midnight Blue / Forest Spirit / Sunset Warm / Aurora Light / Shadow Noir

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9

## Project Structure

```
ios-LunarGo/
├── LunarGo/                  # Main app target
│   ├── App/                 # App entry point
│   ├── Models/              # Data models
│   ├── Services/            # Business logic (Theme, MoonPhase, MoodStore)
│   ├── Views/               # SwiftUI views
│   ├── Assets.xcassets/      # Icons, colors
│   ├── LunarGo.entitlements # App entitlements
│   └── Info.plist           # App configuration
├── LunarGoTests/            # Unit tests
├── LunarGoUITests/          # UI tests
├── AppStore/                # App Store assets
│   ├── Assets/
│   │   ├── Icon/           # App icon source
│   │   └── UI/             # UI design files
│   ├── Screenshots/        # App screenshots
│   ├── Listing.md           # App Store listing
│   └── HOW-TO.md           # Operating instructions
└── Docs/
    └── FeatureList.md       # Complete feature list (76 features)
```

## Build Instructions

1. **Generate Xcode project**
   ```bash
   ~/tools/xcodegen/bin/xcodegen generate
   ```

2. **Build for simulator**
   ```bash
   xcodebuild -project LunarGo.xcodeproj -scheme LunarGo -configuration Debug -destination 'platform=iOS Simulator' build
   ```

3. **Build for archive**
   ```bash
   xcodebuild archive -project LunarGo.xcodeproj -scheme LunarGo -configuration Release
   ```

## App Store

- **Bundle ID**: com.ggsheng.LunarGo
- **Category**: Lifestyle / Health & Fitness
- **Age Rating**: 12+
- **Privacy**: All data stored locally, no tracking

## Privacy Policy

https://lauer3912.github.io/ios-Lunar/docs/PrivacyPolicy.html

## License

Private - All Rights Reserved
Copyright 2026 ZhiFeng Sun