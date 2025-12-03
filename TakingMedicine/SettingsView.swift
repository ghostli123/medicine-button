import SwiftUI

struct SettingsView: View {
    @ObservedObject var reminderManager: ReminderManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Enable Reminders", isOn: $reminderManager.reminderEnabled)
                        .onChange(of: reminderManager.reminderEnabled) { _ in
                            reminderManager.saveSettings()
                        }
                    
                    if reminderManager.reminderEnabled {
                        DatePicker(
                            "Reminder Time",
                            selection: $reminderManager.reminderTime,
                            displayedComponents: .hourAndMinute
                        )
                        .onChange(of: reminderManager.reminderTime) { _ in
                            reminderManager.saveSettings()
                        }
                    }
                } header: {
                    Text("Daily Reminders")
                } footer: {
                    if reminderManager.reminderEnabled {
                        Text("You'll receive a notification at the selected time each day to remind you to take your medicine.")
                    } else {
                        Text("Enable reminders to get daily notifications to take your medicine.")
                    }
                }
                
                Section {
                    Button(action: {
                        reminderManager.requestNotificationPermission()
                    }) {
                        HStack {
                            Text("Notification Permissions")
                            Spacer()
                            Image(systemName: "arrow.right.circle")
                        }
                    }
                } footer: {
                    Text("Make sure notifications are enabled in Settings to receive reminders.")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(reminderManager: ReminderManager())
}

