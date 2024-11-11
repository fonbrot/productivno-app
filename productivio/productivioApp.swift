import SwiftUI
import SwiftData
import UserNotifications

@main
struct productivioApp: App {
    @State private var timer: ProTimer
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Project.self,
            History.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        _timer = State(wrappedValue: ProTimer(modelContext: sharedModelContainer.mainContext))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(timer)
                .onAppear {
                    requestNotificationAuthorization()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    timer.enterBackground()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    timer.enterForeground()
                }
        }
        .modelContainer(sharedModelContainer)
    }
    
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            } else if granted {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        }
    }
}
