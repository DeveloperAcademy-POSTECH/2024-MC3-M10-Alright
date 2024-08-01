import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var noiseLevel: NoiseLevel
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
                Text(context.state.message)
                ProgressView(value: context.state.progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(context.state.noiseLevel.noiseColor)
                    .frame(height: 10)
                    .padding(.horizontal)
            }
            .activityBackgroundTint(.sgmGray2)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {}
                
                DynamicIslandExpandedRegion(.trailing) {}
                
                DynamicIslandExpandedRegion(.bottom) {}
                
                DynamicIslandExpandedRegion(.center) {
                    Text(context.state.message)
                    ProgressView(value: context.state.progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(context.state.noiseLevel.noiseColor)
                        .frame(height: 10)
                        .padding(.horizontal)
                }
            } compactLeading: {
                Image(context.state.noiseLevel.imageString)
            } compactTrailing: {
                Text("\(context.state.noiseLevel.emoji)")
            } minimal: {
                Text("\(context.state.noiseLevel.emoji)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.blue)
        }
    }
}

extension DynamicIslandWidgetAttributes {
    fileprivate static var preview: DynamicIslandWidgetAttributes {
        DynamicIslandWidgetAttributes(name: "World")
    }
}

extension DynamicIslandWidgetAttributes.ContentState {
}

//#Preview("Notification", as: .content, using: DynamicIslandWidgetAttributes.preview) {
//   DynamicIslandWidgetLiveActivity()
//} contentStates: {
//    DynamicIslandWidgetAttributes.ContentState.smiley
//    DynamicIslandWidgetAttributes.ContentState.starEyes
//}
