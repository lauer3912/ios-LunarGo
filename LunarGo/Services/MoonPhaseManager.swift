import Foundation

class MoonPhaseManager: ObservableObject {
    @Published var currentPhase: MoonPhase
    @Published var illumination: Double
    @Published var energyLevel: String

    private let calendar = Calendar.current

    init() {
        let phase = Self.calculateMoonPhase(for: Date())
        self.currentPhase = phase.phase
        self.illumination = phase.illumination
        self.energyLevel = phase.phase.energyLevel
    }

    func updatePhase(for date: Date) {
        let phase = Self.calculateMoonPhase(for: date)
        currentPhase = phase.phase
        illumination = phase.illumination
        energyLevel = phase.phase.energyLevel
    }

    static func calculateMoonPhase(for date: Date) -> (phase: MoonPhase, illumination: Double) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        guard let year = components.year, let month = components.month, let day = components.day else {
            return (.newMoon, 0.0)
        }

        // Known new moon: January 6, 2000
        let knownNewMoon = DateComponents(year: 2000, month: 1, day: 6, hour: 18, minute: 14)
        guard let knownDate = calendar.date(from: knownNewMoon) else {
            return (.newMoon, 0.0)
        }

        // Lunar cycle is approximately 29.53059 days
        let lunarCycle: Double = 29.53059

        let daysSinceKnown = calendar.dateComponents([.day], from: knownDate, to: date).day ?? 0
        let daysDecimal = Double(daysSinceKnown)

        var age = daysDecimal.truncatingRemainder(dividingBy: lunarCycle)
        if age < 0 { age += lunarCycle }

        let illumination = (1 - cos(2 * .pi * age / lunarCycle)) / 2

        let phase: MoonPhase
        switch age {
        case 0..<(lunarCycle * 0.0625):
            phase = .newMoon
        case (lunarCycle * 0.0625)..<(lunarCycle * 0.1875):
            phase = .waxingCrescent
        case (lunarCycle * 0.1875)..<(lunarCycle * 0.3125):
            phase = .firstQuarter
        case (lunarCycle * 0.3125)..<(lunarCycle * 0.4375):
            phase = .waxingGibbous
        case (lunarCycle * 0.4375)..<(lunarCycle * 0.5625):
            phase = .fullMoon
        case (lunarCycle * 0.5625)..<(lunarCycle * 0.6875):
            phase = .waningGibbous
        case (lunarCycle * 0.6875)..<(lunarCycle * 0.8125):
            phase = .lastQuarter
        case (lunarCycle * 0.8125)..<(lunarCycle * 0.9375):
            phase = .waningCrescent
        default:
            phase = .newMoon
        }

        return (phase, illumination)
    }

    func moonPhaseDescription() -> String {
        currentPhase.description
    }
}