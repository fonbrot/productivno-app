import SwiftUI
import SwiftData

struct ProjectEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add project")
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled(name.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func save() {
        let project = Project(name: name)
        modelContext.insert(project)
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ProjectEditor()
    }
}
