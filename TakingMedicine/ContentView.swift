import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var tracker: DailyDoseTracker
    @ObservedObject var reminderManager: ReminderManager
    @State private var now: Date = Date()
    @State private var timerCancellable: AnyCancellable?
    @State private var showSettings = false
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        TabView {
            // Main Tracking View
            mainTrackingView
                .tabItem {
                    Label("Track", systemImage: "pill.fill")
                }
            
            // History View
            HistoryView(tracker: tracker)
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(reminderManager: reminderManager)
        }
    }
    
    private var mainTrackingView: some View {
        VStack(spacing: 24) {
            // Settings Button
            HStack {
                Spacer()
                Button(action: { showSettings = true }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .padding(8)
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            Spacer()

            // Statistics Card
            if tracker.totalDoses() > 0 {
                HStack(spacing: 30) {
                    VStack {
                        Text("\(tracker.currentStreak())")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.blue)
                        Text("Day Streak")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Divider()
                        .frame(height: 40)
                    VStack {
                        Text("\(tracker.totalDoses())")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.green)
                        Text("Total Doses")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal, 24)
            }

            VStack(spacing: 8) {
                Text(statusTitle)
                    .font(.title3)
                    .bold()
                Text(statusSubtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)

            Button(action: handleTap) {
                Text(buttonLabel)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(buttonBackground)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .disabled(!isButtonEnabled)
            .padding(.horizontal, 24)
            .accessibilityIdentifier("doseButton")

            if let countdown = countdownText {
                Text(countdown)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    now = Date()
                }
            }
    }
    
    private func startTimer() {
        stopTimer()
        timerCancellable = Timer.publish(every: 60.0, on: .main, in: .common)
            .autoconnect()
            .sink { date in
                now = date
            }
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    private var isButtonEnabled: Bool {
        !tracker.hasRecordedDose(on: now)
    }

    private var buttonLabel: String {
        isButtonEnabled ? "Mark as Taken" : "Already recorded today"
    }

    private var buttonBackground: Color {
        isButtonEnabled ? .accentColor : .gray
    }

    private var statusTitle: String {
        if tracker.hasRecordedDose(on: now) {
            return "All set for today"
        } else {
            return "Medicine not logged yet"
        }
    }

    private var statusSubtitle: String {
        guard let lastDate = tracker.lastTakenDate else {
            return "Tap the button once they have taken the medicine."
        }

        if tracker.hasRecordedDose(on: now) {
            return "Last confirmed \(relativeFormatter.localizedString(for: lastDate, relativeTo: now))."
        } else {
            let dateString = preciseFormatter.string(from: lastDate)
            return "Last confirmed on \(dateString)."
        }
    }

    private var countdownText: String? {
        guard tracker.hasRecordedDose(on: now),
              let nextReset = tracker.nextResetDate(from: now)
        else { return nil }

        let seconds = nextReset.timeIntervalSince(now)
        guard seconds > 0 else { return nil }
        return "Button resets in \(countdownFormatter.string(from: seconds) ?? "less than a minute")."
    }

    private func handleTap() {
        guard isButtonEnabled else { return }
        tracker.markDoseTaken(at: now)
        now = Date()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// MARK: - Formatters

private let relativeFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter
}()

private let preciseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

private let countdownFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .short
    formatter.allowedUnits = [.hour, .minute]
    formatter.zeroFormattingBehavior = .dropAll
    return formatter
}()

#Preview("Enabled state") {
    ContentView(tracker: DailyDoseTracker(), reminderManager: ReminderManager())
}

