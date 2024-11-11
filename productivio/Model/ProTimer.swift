import Foundation
import SwiftUI
import SwiftData
import AVFoundation

@Observable
final class ProTimer {
    let settings = Settings()
    
    let modelContext: ModelContext
    
    var secondsRemaining = 0
    var secondsTotal = 0
    var state: TimerState = .idle
    var isWork = true { didSet { updateTime() } }
    var project: Project?
    
    private weak var timer: Timer?
    
    private var finishTime: Date = Date()
    private var workIntervals: Int = 0
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    private var workIntervalTime: Int { settings.workIntervalTime * 60 }
    private var shortRestIntervalTime: Int { settings.shortRestIntervalTime * 60 }
    private var longRestIntervalTime: Int { settings.longRestIntervalTime * 60 }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        isWork = true
    }
    
    func updateTime() {
        if isWork {
            secondsTotal = workIntervalTime
            secondsRemaining = workIntervalTime
        } else {
            var time = shortRestIntervalTime
            if workIntervals >= settings.workIntervalSet {
                workIntervals = 0
                time = longRestIntervalTime
            }
            secondsTotal = time
            secondsRemaining = time
        }
    }
    
    func startStop() {
        switch state {
        case .idle:
            if isWork {
                state = .work
            } else {
                state = .rest
            }
            startTimer()
        case .work:
            stopTimer()
            state = .idle
            updateTime()
        case .rest:
            stopTimer()
            isWork = true
            state = .idle
        }
    }
    
    func timerFired(fromBackground: Bool = false)  {
        switch state {
        case .idle:
            break
        case .work:
            onWorkFinish()
            isWork = false
            if !fromBackground, settings.isStartBreak {
                state = .rest
                startTimer()
            } else {
                state = .idle
                stopTimer()
            }
        case .rest:
            isWork = true
            if !fromBackground, settings.isStartAfterBreak {
                state = .work
                startTimer()
            } else {
                state = .idle
                stopTimer()
            }
        }
    }
    
    func onWorkFinish() {
        workIntervals += 1
        if settings.isPlayFinishEnabled {
            player.seek(to: .zero)
            player.play()
        }
        let history = History(name: project?.name)
        modelContext.insert(history)
    }
    
    func startTimer() {
        finishTime = Date().addingTimeInterval(TimeInterval(secondsRemaining))
        runTimer()
    }
    
    func runTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1/10, repeats: true) { [weak self] timer in
            self?.updateTimer()
        }
        timer?.tolerance = 0.1
    }
    
    func updateTimer() {
        Task { @MainActor in
            secondsRemaining = max(Int(finishTime.timeIntervalSince(Date())), 0)
            if secondsRemaining == 0 {
                timerFired()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func scheduleTimerCompletionNotification() {
        guard state != .idle, secondsRemaining > 0 else { return }
        let content = UNMutableNotificationContent()
        content.title = "Timer Completed"
        content.body = isWork ? "Work interval finished." : "Rest interval finished."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondsRemaining), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func enterBackground() {
        stopTimer()
        scheduleTimerCompletionNotification()
    }
    
    func enterForeground() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        guard state != .idle else { return }
        secondsRemaining = Int(finishTime.timeIntervalSinceNow)
        if secondsRemaining > 0 {
            runTimer()
        } else {
            timerFired(fromBackground: true)
        }
    }
    
    func checkTime() {
        if state == .idle {
            updateTime()
        }
    }
}
