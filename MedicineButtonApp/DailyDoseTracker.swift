import Foundation

/// Handles persistence and date math for the once-per-day dose button.
final class DailyDoseTracker: ObservableObject {
    @Published private(set) var lastTakenDate: Date?

    private let storageKey = "com.medicinebutton.lastTakenDate"
    private let defaults: UserDefaults
    private let calendar: Calendar

    init(defaults: UserDefaults = .standard, calendar: Calendar = .current) {
        self.defaults = defaults
        self.calendar = calendar
        self.lastTakenDate = defaults.object(forKey: storageKey) as? Date
    }

    /// Records that the medicine was taken at the supplied time.
    func markDoseTaken(at date: Date = Date()) {
        lastTakenDate = date
        defaults.set(date, forKey: storageKey)
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
}

