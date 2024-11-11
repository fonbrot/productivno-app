import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("workIntervalTime") var workIntervalTime = AppConstants.workIntervalTime
    @AppStorage("shortRestIntervalTime") var shortRestIntervalTime = AppConstants.shortRestIntervalTime
    @AppStorage("longRestIntervalTime") var longRestIntervalTime = AppConstants.longRestIntervalTime
    @AppStorage("workIntervalSet") var workIntervalSet = AppConstants.workIntervalSet
    @AppStorage("isStartAfterBreak") var isStartAfterBreak = AppConstants.isStartAfterBreak
    @AppStorage("isStartBreak") var isStartBreak = AppConstants.isStartBreak
    @AppStorage("isPlayFinishEnabled") var isPlayFinishEnabled = AppConstants.isPlayFinishEnabled
    @State private var isPresentingHelp = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    Stepper("Pomodoro length: \(workIntervalTime)", value: $workIntervalTime, in: 1...59, step: 1)
                    
                    Stepper("Short break length: \(shortRestIntervalTime)", value: $shortRestIntervalTime, in: 1...59, step: 1)
                    
                    Stepper("Long break length: \(longRestIntervalTime)", value: $longRestIntervalTime, in: 1...59, step: 1)
                    
                    Stepper("Long break after: \(workIntervalSet)", value: $workIntervalSet, in: 1...59, step: 1)
                }
                
                Section() {
                    Toggle("Auto start next pomodoro", isOn: $isStartAfterBreak)
                    
                    Toggle("Auto start break", isOn: $isStartBreak)
                }
                
                Section() {
                    Toggle("Play sound", isOn: $isPlayFinishEnabled)
                }
                
                Section() {
                    Button(action: { isPresentingHelp = true }) {
                        Label { Text("Help")
                        } icon: {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    
                    Button(action: { openMail() }) {
                        Label { Text("Send feedback")
                        } icon: {
                            Image(systemName: "envelope")
                        }
                    }
                    
                    Button(action: { openStore() }) {
                        Label { Text("Rate app")
                        } icon: {
                            Image(systemName: "star")
                        }
                    }
                }
                .foregroundColor(.mainColor)
                
                Section() {
                    Text(String(localized: "Version") + " " + appVersion)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close", role: .cancel) {
                            dismiss()
                        }
                        .foregroundColor(.mainColor)
                    }
                }
                .sheet(isPresented: $isPresentingHelp) {
                    HelpView()
                }
                .navigationTitle("Settings")
        }
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var mailTo: String {
        "mailto:productivno@outlook.com?subject=Feedback".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func openMail() {
       if let url = URL(string: mailTo),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func openStore() {
        if let url = URL(string: "https://apps.apple.com/app/6738010376"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

#Preview {
    SettingsView()
}
