import SwiftUI
import Charts

struct HistoryChart: View {
    var entries: [Entry]
    
    var body: some View {
        Chart(entries) { entry in
            BarMark(
                x: .value("Date", entry.date, unit: .day),
                y: .value("Count", entry.count)
            )
            .foregroundStyle(Color.mainColor)
        }
    }
}

struct Entry: Identifiable {
    var id: Date { date }
    var date: Date
    var count: Int
}

#Preview {
    let sampleData: [Entry] = [
        Entry(date: Date().addingTimeInterval(-86400 * 6), count: 5),
        Entry(date: Date().addingTimeInterval(-86400 * 5), count: 8),
        Entry(date: Date().addingTimeInterval(-86400 * 4), count: 2),
        Entry(date: Date().addingTimeInterval(-86400 * 3), count: 7),
        Entry(date: Date().addingTimeInterval(-86400 * 2), count: 3),
        Entry(date: Date().addingTimeInterval(-86400), count: 6),
        Entry(date: Date(), count: 4)
    ]
    HistoryChart(entries: sampleData)
}
