import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        let decibels: Int
        let noiseLevel: NoiseLevel
        let progress: Int
        let title: String
    }
    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandWidgetLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandWidgetAttributes.self) { context in
            // Lock Screen 혹은 Banner에서 사용하는 View
            VStack {
                HStack {
                    Text("Alight")
                        .foregroundStyle(.sgmWhite)
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.leading)
                    
                    Spacer()
                    
                    Text("\(context.state.title)")
                        .foregroundStyle(.sgmGrayA)
                        .font(.system(size: 16, weight: .regular))
                        .padding(.trailing)
                }
                .padding([.top, .horizontal])
                
                HStack(spacing: 10) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.clear)
                            .frame(width: 95, height: 48)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(context.state.noiseLevel.noiseBorderGradientColor, lineWidth: 1)
                            )
                        HStack(alignment: .bottom, spacing: 1) {
                            Text("\(context.state.noiseLevel.emoji)")
                                .padding(.bottom, 2)
                            Text("\(context.state.decibels)")
                                .foregroundStyle(.sgmWhite)
                                .font(.system(size: 22, weight: .semibold))
                            Text("dB")
                                .foregroundStyle(.sgmWhite)
                                .font(.system(size: 16, weight: .regular))
                                .padding(.bottom, 2)
                        }
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 222, height: 48)
                        
                        RoundedRectangle(cornerRadius: 24)
                            .fill(context.state.noiseLevel.noiseGradientColor)
                            .frame(width: CGFloat(context.state.progress) / 100 * 222, height: 48)
                    }
                }
                .padding([.bottom, .horizontal])
            }
            .activityBackgroundTint(.sgmGray2)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded Mode에서 나타날 View 구현
                // Dynamice Island 좌측에 표시되는 영역
                DynamicIslandExpandedRegion(.leading) {
                    HStack(alignment: .bottom) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.clear)
                                .frame(width: 95, height: 48)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(context.state.noiseLevel.noiseBorderGradientColor, lineWidth: 1)
                                )
                            HStack(alignment: .bottom, spacing: 1) {
                                Text("\(context.state.noiseLevel.emoji)")
                                    .fixedSize()
                                    .padding(.bottom,2)
                                Text("\(context.state.decibels)")
                                    .foregroundStyle(.sgmWhite)
                                    .font(.system(size: 22, weight: .semibold))
                                    .frame(width: 30)
                                Text("dB")
                                    .foregroundStyle(.sgmWhite)
                                    .font(.system(size: 16, weight: .regular))
                                    .padding(.bottom, 2)
                            }
                        }
                        .padding(.leading, 8)
                    }
                }
                
                // Dynamic Island 우측에 표시되는 영역
                DynamicIslandExpandedRegion(.trailing) {
                    
                    ZStack {
                        Circle()
                            .fill(.sgmGray2)
                            .frame(width: 40, height: 40)
                        
                        Button(intent: EndLiveActivityIntent()) {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.sgmGrayA)
                                .bold()
                                .padding(14)
                        }
                        .frame(width: 40, height: 40)
                    }
                    .padding(.trailing, 8)
                }
                
                // Dynamic Island 바로 하단에 표시되는 영역
                DynamicIslandExpandedRegion(.center) { }
                
                // Dynamic Island center 하단에 표시되는 영역
                // center가 없을 시 center에 위치
                DynamicIslandExpandedRegion(.bottom) {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: geometry.size.width, height: 29)
                            
                            RoundedRectangle(cornerRadius: 24)
                                .fill(context.state.noiseLevel.noiseGradientColor)
                                .frame(width: geometry.size.width * CGFloat(context.state.progress) / 100, height: 29)
                        }
                    }
                    .padding(.bottom, 18)
                    .padding(.horizontal, 11)
                }
            } compactLeading: { // compact Mode에서 좌측에 나타나는 View
                HStack(alignment: .bottom, spacing: 1) {
                    Text("\(context.state.decibels)")
                        .foregroundStyle(.sgmWhite)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 22)
                    Text("dB")
                        .foregroundStyle(.sgmWhite)
                        .font(.system(size: 10, weight: .regular))
                        .padding(.bottom, 2)
                }
            } compactTrailing: { // compact Mode에서 우측에 나타나는 View
                Image(context.state.noiseLevel.imageString)
            } minimal: { // compact Mode에서 여러 앱이 떠야 할 때 좌측 작은 원으로 나타날 시의 View
                HStack(alignment: .bottom, spacing: 1) {
                    Text("\(context.state.decibels)")
                        .foregroundStyle(.sgmWhite)
                        .font(.system(size: 16, weight: .semibold))
                        .fixedSize()
                    Text("dB")
                        .foregroundStyle(.sgmWhite)
                        .font(.system(size: 10, weight: .regular))
                        .fixedSize()
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.blue)
        }
    }
}
