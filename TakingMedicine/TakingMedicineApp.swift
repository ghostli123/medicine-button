import SwiftUI

@main
struct TakingMedicineApp: App {
    @StateObject private var tracker = DailyDoseTracker()

    var body: some Scene {
        WindowGroup {
            ContentView(tracker: tracker)
        }
    }
}

