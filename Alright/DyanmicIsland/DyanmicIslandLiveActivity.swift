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
                    Text("Alright")
                        .font(.Pretendard.SemiBold.size24)
                        .foregroundStyle(.sgmWhite)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Text("\(context.state.title)")
                        .font(.Pretendard.Regular.size16)
                        .foregroundStyle(.sgmGrayA)
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
                        HStack(spacing: 1) {
                            Text("\(context.state.noiseLevel.emoji)")
                                .font(.Pretendard.SemiBold.size22)
                            
                            Text("\(context.state.decibels)")
                                .font(.Pretendard.SemiBold.size22)
                                .foregroundStyle(.sgmWhite)
                                .frame(width: 30)
                            
                            Text("dB")
                                .font(.Pretendard.Regular.size16)
                                .foregroundStyle(.sgmWhite)
                                .padding(.top, 3)
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
                                    .font(.Pretendard.SemiBold.size22)
                                
                                Text("\(context.state.decibels)")
                                    .font(.Pretendard.SemiBold.size22)
                                    .foregroundStyle(.sgmWhite)
                                    .frame(width: 30)
                                
                                Text("dB")
                                    .font(.Pretendard.Regular.size16)
                                    .foregroundStyle(.sgmWhite)
                                    .padding(.top, 3)
                            }
                        }
                        .padding(.leading, 8)
                    }
                }
                
                // Dynamic Island 우측에 표시되는 영역
                DynamicIslandExpandedRegion(.trailing) {
                    
                    
                    Button(intent: EndLiveActivityIntent()) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .bold()
                            .padding(8)
                    }
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 18)
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
                        .font(.Pretendard.SemiBold.size16)
                        .foregroundStyle(.sgmWhite)
                        .frame(width: 22)
                    Text("dB")
                        .font(.Pretendard.Regular.size10)
                        .foregroundStyle(.sgmWhite)
                        .padding(.bottom, 2)
                }
            } compactTrailing: { // compact Mode에서 우측에 나타나는 View
                Image(context.state.noiseLevel.imageString)
            } minimal: { // compact Mode에서 여러 앱이 떠야 할 때 좌측 작은 원으로 나타날 시의 View
                HStack(alignment: .bottom, spacing: 1) {
                    Text("\(context.state.decibels)")
                        .font(.Pretendard.SemiBold.size16)
                        .foregroundStyle(.sgmWhite)
                        .fixedSize()
                    Text("dB")
                        .font(.Pretendard.Regular.size10)
                        .foregroundStyle(.sgmWhite)
                        .fixedSize()
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.blue)
        }
    }
}
