import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("""

Master your time and boost productivity using the Pomodoro Technique.

**What is the Pomodoro Technique?**

The Pomodoro Technique is a time management method. It involves breaking your workday into 25-minute focused intervals called "Pomodoros," separated by short breaks. This technique helps improve concentration and reduces mental fatigue.

**How it works:**

1. **Choose a Task**: Select a task you want to accomplish.
2. **Set the Timer**: Start a 25-minute Pomodoro session.
3. **Work Focusedly**: Concentrate on the task without interruptions.
4. **Take a Short Break**: After 25 minutes, take a 5-minute break.
5. **Repeat**: After four Pomodoros, take a longer break (15-30 minutes).

**Using App**

- **Start a Pomodoro Session**: Tap the "Start" button to begin a 25-minute timer.
- **Break Notifications**: The app will alert you when it's time to take a break.
- **Customize Timers**: Adjust Pomodoro and break lengths in the settings to suit your preferences.
- **Track Progress**: Monitor your completed Pomodoros and track your productivity stats.

### **Tips for Effective Use**

- **Eliminate Distractions**: Turn off unrelated notifications during Pomodoro sessions.
- **Prioritize Tasks**: Tackle the most important tasks during your peak productivity hours.
- **Stay Consistent**: Make the Pomodoro Technique a regular part of your routine.
- **Adjust as Needed**: Feel free to modify the intervals to find what works best for you.


Thank you for choosing App! We’re excited to help you enhance your productivity with the Pomodoro Technique.

""")
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", role: .cancel) {
                        dismiss()
                    }
                    .foregroundColor(.mainColor)
                }
            }
            .navigationTitle("Help")
        }
    }
}

#Preview {
    HelpView()
}
