import Foundation
import UserNotifications

/// Manages medication reminders and local notifications
final class ReminderManager: ObservableObject {
    @Published var reminderEnabled: Bool = false
    @Published var reminderTime: Date = {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = 9
        components.minute = 0
        return calendar.date(from: components) ?? Date()
    }()
    
    private let reminderEnabledKey = "com.medicinebutton.reminderEnabled"
    private let reminderTimeKey = "com.medicinebutton.reminderTime"
    private let notificationIdentifier = "medicineReminder"
    
    init() {
        loadSettings()
        requestNotificationPermission()
    }
    
    // MARK: - Settings Management
    
    func loadSettings() {
        let defaults = UserDefaults.standard
        reminderEnabled = defaults.bool(forKey: reminderEnabledKey)
        
        if let savedTime = defaults.object(forKey: reminderTimeKey) as? Date {
            reminderTime = savedTime
        }
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(reminderEnabled, forKey: reminderEnabledKey)
        defaults.set(reminderTime, forKey: reminderTimeKey)
        
        if reminderEnabled {
            scheduleReminder()
        } else {
            cancelReminder()
        }
    }
    
    // MARK: - Notification Permission
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }
            }
        }
    }
    
    // MARK: - Reminder Scheduling
    
    func scheduleReminder() {
        cancelReminder() // Remove any existing reminder
        
        guard reminderEnabled else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Time to Take Your Medicine"
        content.body = "Don't forget to take your daily medication!"
        content.sound = .default
        content.badge = 1
        
        // Schedule for the specified time each day
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: reminderTime)
        
        var dateComponents = DateComponents()
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling reminder: \(error.localizedDescription)")
            } else {
                print("Reminder scheduled for \(components.hour ?? 0):\(components.minute ?? 0)")
            }
        }
    }
    
    func cancelReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationIdentifier])
    }
    
    // MARK: - Snooze
    
    func snoozeReminder(minutes: Int = 30) {
        cancelReminder()
        
        let content = UNMutableNotificationContent()
        content.title = "Time to Take Your Medicine"
        content.body = "Don't forget to take your daily medication!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(minutes * 60), repeats: false)
        let request = UNNotificationRequest(identifier: "\(notificationIdentifier)_snooze", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling snooze: \(error.localizedDescription)")
            }
        }
    }
}

