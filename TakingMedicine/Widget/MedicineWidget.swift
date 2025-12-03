import WidgetKit
import SwiftUI

struct MedicineWidget: Widget {
    let kind: String = "MedicineWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MedicineTimelineProvider()) { entry in
            MedicineWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Medicine Tracker")
        .description("Quickly see if you've taken your medicine today and mark it as taken.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct MedicineTimelineProvider: TimelineProvider {
    typealias Entry = MedicineWidgetEntry
    
    func placeholder(in context: Context) -> MedicineWidgetEntry {
        MedicineWidgetEntry(date: Date(), hasTakenToday: false, streak: 0, totalDoses: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MedicineWidgetEntry) -> Void) {
        let entry = createEntry()
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MedicineWidgetEntry>) -> Void) {
        let entry = createEntry()
        // Update every hour to refresh the status
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
    
    private func createEntry() -> MedicineWidgetEntry {
        let tracker = DailyDoseTracker()
        let hasTakenToday = tracker.hasRecordedDose(on: Date())
        let streak = tracker.currentStreak()
        let totalDoses = tracker.totalDoses()
        
        return MedicineWidgetEntry(
            date: Date(),
            hasTakenToday: hasTakenToday,
            streak: streak,
            totalDoses: totalDoses
        )
    }
}

struct MedicineWidgetEntry: TimelineEntry {
    let date: Date
    let hasTakenToday: Bool
    let streak: Int
    let totalDoses: Int
}

struct MedicineWidgetEntryView: View {
    var entry: MedicineWidgetEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

struct SmallWidgetView: View {
    var entry: MedicineWidgetEntry
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: entry.hasTakenToday ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(entry.hasTakenToday ? .green : .gray)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.hasTakenToday ? "Taken" : "Not Taken")
                    .font(.headline)
                    .foregroundStyle(entry.hasTakenToday ? .green : .orange)
                
                Text("Today")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(entry.streak)")
                        .font(.title2)
                        .bold()
                    Text("Streak")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct MediumWidgetView: View {
    var entry: MedicineWidgetEntry
    
    var body: some View {
        HStack(spacing: 16) {
            // Status Section
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: entry.hasTakenToday ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                        .foregroundStyle(entry.hasTakenToday ? .green : .gray)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(entry.hasTakenToday ? "Taken Today" : "Not Taken")
                            .font(.headline)
                            .foregroundStyle(entry.hasTakenToday ? .green : .orange)
                        Text(Date(), style: .date)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
            }
            
            Divider()
            
            // Statistics Section
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(entry.streak)")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.blue)
                        Text("Day Streak")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("\(entry.totalDoses)")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.green)
                        Text("Total Doses")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

#Preview(as: .systemSmall) {
    MedicineWidget()
} timeline: {
    MedicineWidgetEntry(date: Date(), hasTakenToday: true, streak: 5, totalDoses: 30)
    MedicineWidgetEntry(date: Date(), hasTakenToday: false, streak: 0, totalDoses: 0)
}

#Preview(as: .systemMedium) {
    MedicineWidget()
} timeline: {
    MedicineWidgetEntry(date: Date(), hasTakenToday: true, streak: 5, totalDoses: 30)
    MedicineWidgetEntry(date: Date(), hasTakenToday: false, streak: 0, totalDoses: 0)
}

