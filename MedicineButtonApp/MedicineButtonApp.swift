import SwiftUI

@main
struct MedicineButtonApp: App {
    @StateObject private var tracker = DailyDoseTracker()

    var body: some Scene {
        WindowGroup {
            ContentView(tracker: tracker)
        }
    }
}

