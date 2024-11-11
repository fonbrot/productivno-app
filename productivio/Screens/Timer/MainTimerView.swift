import SwiftUI
import SwiftData

struct MainTimerView: View {
    @State private var isPresentingSettings = false
    @State private var isPresentingChart = false
    @State private var isPresentingProjects = false
    @Environment(ProTimer.self) private var timer
    
    var body: some View {
        NavigationStack {
            ZStack {
                TimerView()
                    .frame(maxWidth: 400)
                VStack {
                    ProjectView(isPresentingProjects: $isPresentingProjects)
                        .padding(.top, 30)
                    Spacer()
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresentingChart = true
                    }) {
                        Image(systemName: "chart.xyaxis.line")
                    }
                    .foregroundColor(.mainColor)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingSettings = true
                    }) {
                        Image(systemName: "gear")
                    }
                    .foregroundColor(.mainColor)
                }
            }
            .sheet(isPresented: $isPresentingSettings, onDismiss: {
                timer.checkTime()
            }) {
                SettingsView()
            }
            .sheet(isPresented: $isPresentingChart) {
                ChartView()
            }
            .sheet(isPresented: $isPresentingProjects) {
                ProjectsView()
            }
        }
    }
    
    func openProjects() {
        isPresentingProjects = true
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        MainTimerView()
    }
}
