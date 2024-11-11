import Foundation
import SwiftData

@Model
final class History {
    var id = UUID()
    var date = Date()
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
}
