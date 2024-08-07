import WidgetKit
import AppIntents

struct EndLiveActivityIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "End Live Activity"
    
    func perform() async throws -> some IntentResult {
        print("Attempting to end Live Activity")
        await NoiseMeter.shared.endLiveActivity()
        print("Live Activity ended successfully.")
        return .result()
    }
}
