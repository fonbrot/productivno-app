import SwiftUI

struct Settings {
    @AppStorage("workIntervalTime") var workIntervalTime = AppConstants.workIntervalTime
    @AppStorage("shortRestIntervalTime") var shortRestIntervalTime = AppConstants.shortRestIntervalTime
    @AppStorage("longRestIntervalTime") var longRestIntervalTime = AppConstants.longRestIntervalTime
    @AppStorage("workIntervalSet") var workIntervalSet = AppConstants.workIntervalSet
    @AppStorage("isStartAfterBreak") var isStartAfterBreak = AppConstants.isStartAfterBreak
    @AppStorage("isStartBreak") var isStartBreak = AppConstants.isStartBreak
    @AppStorage("isPlayFinishEnabled") var isPlayFinishEnabled = AppConstants.isPlayFinishEnabled
}
