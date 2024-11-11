import SwiftUI
import SwiftData

struct ProjectsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Project.id) private var allProjects: [Project]
    @State private var isEditorPresented = false
    @Environment(ProTimer.self) private var timer
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var projects: [Project] {
        if searchText.isEmpty {
            allProjects
        } else {
            allProjects.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(projects) { project in
                    HStack {
                        Text(project.name)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        rowSelected(project)
                    }
                }
                .onDelete(perform: remove)
            }
            .searchable(text: $searchText)
            .sheet(isPresented: $isEditorPresented) {
                ProjectEditor()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isEditorPresented = true
                    } label: {
                        Label("Add project", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Projects")
        }
    }
    
    private func remove(at indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
        }
    }
    
    private func rowSelected(_ project: Project) {
        timer.project = project
        dismiss()
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ProjectsView()
    }
}
