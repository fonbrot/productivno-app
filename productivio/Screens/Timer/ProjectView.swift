import SwiftUI
import SwiftData

struct ProjectView: View {
    @Environment(ProTimer.self) private var timer
    @Binding var isPresentingProjects: Bool
    
    var body: some View {
        HStack {
            Text(timer.project?.name ?? "")
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.mainColor.opacity(0.3))
                )
            Button(action: {
                isPresentingProjects = true
            }) {
                Image(systemName: "line.3.horizontal")
            }
            .buttonStyle(RoundedButtonStyle(backgroundColor: .mainColor))
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ProjectView(isPresentingProjects: .constant(true))
    }
}
