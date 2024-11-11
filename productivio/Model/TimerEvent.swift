enum TimerState {
    case idle, work, rest
}

enum Mode {
    case work, rest
}

enum Timeframe: String, Hashable, CaseIterable {
    case week
    case month
    case year
}
