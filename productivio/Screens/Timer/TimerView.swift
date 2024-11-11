import SwiftUI
import SwiftData

struct TimerView: View {
    
    @Environment(ProTimer.self) private var timer
    
    var body: some View {
        Circle()
            .stroke(Color.yellowColor, lineWidth: 10)
            .overlay {
                VStack(spacing: 50) {
                    Text(timeLeftString)
                        .font(.system(size: 72))
                        .foregroundColor(.mainColor)
                    
                    HStack(spacing: 20) {
                        Button {
                            timer.startStop()
                        } label: {
                            Label(buttonText, systemImage: buttonIcon)
                        }
                        .buttonStyle(RoundedButtonStyle(backgroundColor: .mainColor))
                    }
                }
            }
            .overlay {
                TimerArc(secondsRemaining: timer.secondsRemaining, secondsTotal: timer.secondsTotal)
                    .rotation(Angle(degrees: -90))
                    .stroke(Color.mainColor, lineWidth: 5)
            }
    }
    
    var timeLeftString: String {
        String(format: "%.2i:%.2i",
               timer.secondsRemaining / 60,
               timer.secondsRemaining % 60
        )
    }
    
    var buttonText: String {
        switch timer.state {
        case .idle:
           "Start"
        case .work:
            "Stop"
        case .rest:
            "Skip"
        }
    }
    
    var buttonIcon: String {
        switch timer.state {
        case .idle:
            "play"
        case .work:
            "stop"
        case .rest:
            "arrow.forward.to.line"
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        TimerView()
    }
}
