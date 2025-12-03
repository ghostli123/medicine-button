import SwiftUI
import UserNotifications

@main
struct TakingMedicineApp: App {
    @StateObject private var tracker = DailyDoseTracker()
    @StateObject private var reminderManager = ReminderManager()

    init() {
        // Request notification permission on app launch
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                print("Notification permission granted")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(tracker: tracker, reminderManager: reminderManager)
                .onAppear {
                    // Schedule reminder if enabled
                    if reminderManager.reminderEnabled {
                        reminderManager.scheduleReminder()
                    }
                }
        }
    }
}

