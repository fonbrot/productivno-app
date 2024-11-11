import SwiftUI
import SwiftData
import Charts

struct ChartView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\History.date, order: .reverse)]) private var histories: [History]
    @State private var timeframe: Timeframe = .week
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Picker("Timeframe", selection: $timeframe) {
                            Label("Week", systemImage: "calendar")
                                .tag(Timeframe.week)
                            
                            Label("Month", systemImage: "calendar")
                                .tag(Timeframe.month)
                            
                            Label("Year", systemImage: "calendar")
                                .tag(Timeframe.year)
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom, 10)
                        
                        HistoryChart(entries: entries)
                            .frame(height: 200)
                    }
                }
                
                Section {
                    ForEach(filteredHistories) { history in
                        HistoryRowView(history: history)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button(action: resetHistory) {
                            Label("Reset History", systemImage: "arrow.counterclockwise")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .foregroundColor(.mainColor)
            .navigationTitle("History")
        }
    }
    
    var entries: [Entry] {
        let calendar = Calendar.current
        let groupedHistories = Dictionary(grouping: filteredHistories) { history in
            calendar.startOfDay(for: history.date)
        }
        return groupedHistories.map { (date, histories) in
            Entry(date: date, count: histories.count)
        }
        .sorted { $0.date < $1.date }
    }
    
    var filteredHistories: [History] {
        let calendar = Calendar.current
        let now = Date()
        let startDate: Date
        
        switch timeframe {
        case .week:
            startDate = calendar.date(byAdding: .day, value: -7, to: now)!
        case .month:
            startDate = calendar.date(byAdding: .month, value: -1, to: now)!
        case .year:
            startDate = calendar.date(byAdding: .year, value: -1, to: now)!
        }
        
        return histories.filter { $0.date >= startDate && $0.date <= now }
    }
    
    func resetHistory() {
        do {
            try modelContext.delete(model: History.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ChartView()
    }
}
