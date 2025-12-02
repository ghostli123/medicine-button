import SwiftUI

struct HistoryView: View {
    @ObservedObject var tracker: DailyDoseTracker
    
    var body: some View {
        NavigationView {
            List {
                // Statistics Section
                Section("Statistics") {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Current Streak")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(tracker.currentStreak()) days")
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Total Doses")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(tracker.totalDoses())")
                                .font(.title2)
                                .bold()
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Recent History Section
                Section("Recent History") {
                    if tracker.doseHistory.isEmpty {
                        Text("No doses recorded yet")
                            .foregroundStyle(.secondary)
                            .italic()
                    } else {
                        ForEach(tracker.historyForLastDays(30), id: \.self) { date in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(date, style: .date)
                                        .font(.body)
                                    Text(date, style: .time)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                if Calendar.current.isDate(date, inSameDayAs: Date()) {
                                    Text("Today")
                                        .font(.caption)
                                        .foregroundStyle(.blue)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView(tracker: DailyDoseTracker())
}

