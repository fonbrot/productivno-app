import SwiftUI

struct TimerArc: Shape {
    let secondsRemaining: Int
    let secondsTotal: Int
    
    private var degreesPerSeconds: Double {
        360.0 / Double(secondsTotal)
    }
    private var endAngle: Angle {
        Angle(degrees: Double(secondsRemaining) * degreesPerSeconds)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 3.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: endAngle, clockwise: false)
        }
    }
}
