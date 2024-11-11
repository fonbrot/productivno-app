import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        MainTimerView()
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ContentView()
    }
}
