import SwiftData
import Foundation

extension History {

    static func insertSampleData(modelContext: ModelContext) {
        let calendar = Calendar.current
        let now = Date()
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: now)!
        let projectNames = [
            "Learn a New Language",
            "Write a Short Story",
            "Organize Digital Photos",
            "Develop a Personal Website",
            "Study for a Certification Exam",
            "Create a Budget Plan",
            "Learn to Play a Musical Instrument",
            "Read a Non-Fiction Book",
            "Organize Your Workspace",
            "Establish an Exercise Routine"
        ]
        
        for _ in 0..<100 {
            let randomTimeInterval = TimeInterval.random(in: 0...(now.timeIntervalSince(oneYearAgo)))
            let randomDate = oneYearAgo.addingTimeInterval(randomTimeInterval)
            let randomName = projectNames.randomElement()
            let history = History(name: randomName)
            history.date = randomDate
            modelContext.insert(history)
        }
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: History.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension Project {

    static func insertSampleData(modelContext: ModelContext) {
        let projectNames = [
            "Learn a New Language",
            "Write a Short Story",
            "Organize Digital Photos",
            "Develop a Personal Website",
            "Study for a Certification Exam",
            "Create a Budget Plan",
            "Learn to Play a Musical Instrument",
            "Read a Non-Fiction Book",
            "Organize Your Workspace",
            "Establish an Exercise Routine"
        ]
        for name in projectNames {
            modelContext.insert(Project(name: name))
        }
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Project.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
