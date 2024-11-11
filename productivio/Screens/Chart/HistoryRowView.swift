import SwiftUI

struct HistoryRowView: View {
    var history: History
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(history.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
            
            Text("\(history.name ?? "")")
                .font(.headline)
        }
    }
}

#Preview {
    HistoryRowView(history: History(name: "name"))
}
