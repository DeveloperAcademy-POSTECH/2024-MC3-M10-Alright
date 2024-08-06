import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")
    
    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

struct EndLiveActivityIntent: AppIntent {
    static var title: LocalizedStringResource = "End Live Activity"
    static var description = IntentDescription("Ends the current live activity.")
    
    func perform() async throws -> some IntentResult {
        do {
            print("Attempting to end Live Activity")
            await NoiseMeter.shared.endLiveActivity()
            print("Live Activity ended successfully.")
            return .result()
        } catch {
            print("Failed to end Live Activity: \(error.localizedDescription)")
            throw error
        }
    }
}
