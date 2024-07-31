import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
        var progress: Double
        var message: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("잠금화면 Screen입니다.")
            }
            //.activityBackgroundTint(Color.cyan)
            //.activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    // Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    // Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.message) // Display the message based on noise level
                    ProgressView(value: context.state.progress, total: 1.0) // Dynamic progress
                                            .progressViewStyle(LinearProgressViewStyle())
                                            .frame(height: 10)
                                            .padding(.horizontal)
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("\(context.state.emoji)")
            } minimal: {
                Text("\(context.state.emoji)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DynamicIslandWidgetAttributes {
    fileprivate static var preview: DynamicIslandWidgetAttributes {
        DynamicIslandWidgetAttributes(name: "World")
    }
}

extension DynamicIslandWidgetAttributes.ContentState {
    fileprivate static var smiley: DynamicIslandWidgetAttributes.ContentState {
        DynamicIslandWidgetAttributes.ContentState(emoji: "😀", progress: 0.0, message: "잘하고있어요.")
     }
     
     fileprivate static var starEyes: DynamicIslandWidgetAttributes.ContentState {
         DynamicIslandWidgetAttributes.ContentState(emoji: "🤩", progress: 1.00, message: "작아요")
     }
}

#Preview("Notification", as: .content, using: DynamicIslandWidgetAttributes.preview) {
   DynamicIslandWidgetLiveActivity()
} contentStates: {
    DynamicIslandWidgetAttributes.ContentState.smiley
    DynamicIslandWidgetAttributes.ContentState.starEyes
}
