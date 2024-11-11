import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([History.self, Project.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            History.insertSampleData(modelContext: container.mainContext)
            Project.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
