import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        let decibels: Int
        let noiseLevel: NoiseLevel
        let progress: Int
    }
    
    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandWidgetAttributes.self) { context in
            
            // Lock Screen 혹은 Banner에서 사용하는 View
            VStack {
                Text(context.state.noiseLevel.message)
                ProgressView(value: Float(context.state.progress), total: 100.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(context.state.noiseLevel.noiseColor)
                    .frame(height: 10)
                    .padding(.horizontal)
            }
            .activityBackgroundTint(.sgmGray2)
            
        }
        
        
    dynamicIsland: { context in
        DynamicIsland {
            // Expanded Mode에서 나타날 View 구현
            
            // Dynamice Island 우측에 표시되는 영역
            DynamicIslandExpandedRegion(.leading) {
                VStack(alignment: .trailing) {
                    Text("Alright")
                }
            }
            
            // Dynamic Island 좌측에 표시되는 영역
            DynamicIslandExpandedRegion(.trailing) {}
            
            // Dynamic Island 바로 하단에 표시되는 영역
            DynamicIslandExpandedRegion(.center) {}
            
            // Dynamic Island center 하단에 표시되는 영역
            // center가 없을 시 center에 위치
            DynamicIslandExpandedRegion(.bottom) {
                Text(context.state.noiseLevel.message)
                ProgressView(value: Float(context.state.progress), total: 100.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(context.state.noiseLevel.noiseColor)
                    .frame(height: 10)
                    .padding(.horizontal)
            }
        } compactLeading: { // compact Mode에서 좌측에 나타나는 View
            Image(context.state.noiseLevel.imageString)
        } compactTrailing: { // compact Mode에서 우측에 나타나는 View
            HStack(alignment: .bottom, spacing: 1) {
                Text("\(context.state.decibels)")
                    .foregroundStyle(.sgmWhite)
                    .font(.system(size: 16, weight: .semibold))
                Text("dB")
                    .foregroundStyle(.sgmWhite)
                    .font(.system(size: 10, weight: .regular))
            }
        } minimal: { // compact Mode에서 여러 앱이 떠야 할 때 좌측 작은 원으로 나타날 시의 View
            HStack(alignment: .bottom, spacing: 1) {
                Text("\(context.state.decibels)")
                    .foregroundStyle(.sgmWhite)
                    .font(.system(size: 16, weight: .semibold))
                Text("dB")
                    .foregroundStyle(.sgmWhite)
                    .font(.system(size: 10, weight: .regular))
            }
        }
        .widgetURL(URL(string: "http://www.apple.com"))
        .keylineTint(Color.blue)
    }
    }
}
