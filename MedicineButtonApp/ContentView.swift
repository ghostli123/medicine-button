import SwiftUI

struct ContentView: View {
    @ObservedObject var tracker: DailyDoseTracker
    @State private var now: Date = Date()
    @State private var timer: Timer?
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

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
            } else if scenePhase == .inactive || scenePhase == .background {
                // Timer will continue, but we update time when coming back
            }
        }
    }
    
    private func startTimer() {
        stopTimer() // Ensure no duplicate timers
        let newTimer = Timer(timeInterval: 60.0, repeats: true) { [weak self] _ in
            self?.now = Date()
        }
        RunLoop.main.add(newTimer, forMode: .common)
        timer = newTimer
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
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
    ContentView(tracker: DailyDoseTracker())
}

