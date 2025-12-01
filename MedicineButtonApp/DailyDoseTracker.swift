import Foundation

/// Handles persistence and date math for the once-per-day dose button.
final class DailyDoseTracker: ObservableObject {
    @Published private(set) var lastTakenDate: Date?
    @Published private(set) var doseHistory: [Date] = []
    
    private let lastTakenKey = "com.medicinebutton.lastTakenDate"
    private let historyKey = "com.medicinebutton.doseHistory"
    private let defaults: UserDefaults
    private let calendar: Calendar
    
    init(defaults: UserDefaults = .standard, calendar: Calendar = .current) {
        self.defaults = defaults
        self.calendar = calendar
        self.lastTakenDate = defaults.object(forKey: lastTakenKey) as? Date
        
        // Load history
        if let historyData = defaults.array(forKey: historyKey) as? [TimeInterval] {
            self.doseHistory = historyData.map { Date(timeIntervalSince1970: $0) }
                .sorted(by: >) // Most recent first
        }
    }
    
    /// Records that the medicine was taken at the supplied time.
    func markDoseTaken(at date: Date = Date()) {
        lastTakenDate = date
        defaults.set(date, forKey: lastTakenKey)
        
        // Add to history if not already recorded today
        if !hasRecordedDose(on: date) {
            doseHistory.insert(date, at: 0) // Add to beginning
            saveHistory()
        }
    }
    
    /// Returns true if a dose has already been recorded for the supplied date.
    func hasRecordedDose(on date: Date = Date()) -> Bool {
        guard let stored = lastTakenDate else { return false }
        return calendar.isDate(stored, inSameDayAs: date)
    }
    
    /// Helps the UI know when the next automatic reset will occur.
    func nextResetDate(from reference: Date = Date()) -> Date? {
        calendar.nextDate(
            after: reference,
            matching: DateComponents(hour: 0, minute: 0, second: 0),
            matchingPolicy: .nextTimePreservingSmallerComponents
        )
    }
    
    /// Calculates the current streak of consecutive days with doses.
    func currentStreak() -> Int {
        guard !doseHistory.isEmpty else { return 0 }
        
        let today = calendar.startOfDay(for: Date())
        var streak = 0
        var checkDate = today
        
        // Check if today is recorded
        if hasRecordedDose(on: today) {
            streak = 1
            checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate) ?? checkDate
        }
        
        // Count consecutive days backwards
        while let previousDay = calendar.date(byAdding: .day, value: -1, to: checkDate) {
            let dayStart = calendar.startOfDay(for: previousDay)
            let hasDose = doseHistory.contains { calendar.isDate($0, inSameDayAs: dayStart) }
            
            if hasDose {
                streak += 1
                checkDate = previousDay
            } else {
                break
            }
        }
        
        return streak
    }
    
    /// Gets total number of doses recorded.
    func totalDoses() -> Int {
        return doseHistory.count
    }
    
    /// Gets history for a specific number of days.
    func historyForLastDays(_ days: Int) -> [Date] {
        let cutoffDate = calendar.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        return doseHistory.filter { $0 >= cutoffDate }
    }
    
    /// Checks if a dose was recorded on a specific date.
    func hasDoseOn(_ date: Date) -> Bool {
        return doseHistory.contains { calendar.isDate($0, inSameDayAs: date) }
    }
    
    private func saveHistory() {
        let historyData = doseHistory.map { $0.timeIntervalSince1970 }
        defaults.set(historyData, forKey: historyKey)
    }
}

