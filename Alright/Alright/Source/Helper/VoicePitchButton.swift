import SwiftUI
import ActivityKit

struct VoicePitchButton: View {
    
    let action: () -> Void
    
    @Binding var height: CGFloat
    @Binding var noiseMeter: NoiseMeter
    
    // 상태 변화를 감지하기 위한 변수를 추가합니다.
    @State private var currentNoiseLevel: NoiseLevel = .notMeasuring
    @State private var activity: Activity<DynamicIslandWidgetAttributes>? // Activity 객체를 관리하는 상태 변수 추가
    
    var body: some View {
        Button {
            action()
            // 측정 버튼이 눌릴 때 현재 noiseLevel을 계산하고 출력합니다.
            handleButtonTap()
        } label: {
            Image(noiseMeter.isMeasuring ? "pause" : "record")
        }
        // noiseMeter의 decibels 값이 변경될 때마다 noiseLevel을 업데이트하고 출력합니다.
        .onChange(of: noiseMeter.decibels) { newValue in
            updateNoiseLevelAndPrint()
        }
    }
    
    private func handleButtonTap() {
        if noiseMeter.isMeasuring {
            // 측정을 멈추고 라이브 액티비티 종료
            Task {
                await endLiveActivity()
                // 측정을 멈추는 작업을 여기에 추가
            }
        } else {
            // 측정을 시작하고 라이브 액티비티 시작
            updateNoiseLevelAndPrint()
        }
    }
    
    private func updateNoiseLevelAndPrint() {
        let noiseLevel = NoiseLevel.level(for: noiseMeter.decibels, isMeasuring: noiseMeter.isMeasuring)
        let progress = calculateProgress(for: noiseMeter.decibels) // Calculate progress dynamically
        
        if noiseLevel != currentNoiseLevel {
            currentNoiseLevel = noiseLevel
            print(noiseLevel)
            
            let dynamicIslandWidgetAttributes = DynamicIslandWidgetAttributes(name: "A")
            let contentState = DynamicIslandWidgetAttributes.ContentState(
                emoji: noiseLevel.emoji,
                progress: progress, // Update progress
                message: noiseLevel.rawValue // Update message
            )
            
            if let activity = activity {
                Task {
                    await activity.update(using: contentState)
                }
            } else if noiseMeter.isMeasuring {
                do {
                    let newActivity = try Activity<DynamicIslandWidgetAttributes>.request(
                        attributes: dynamicIslandWidgetAttributes,
                        contentState: contentState
                    )
                    self.activity = newActivity
                    print(newActivity)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private func calculateProgress(for decibels: Float) -> Double {
        // Assuming decibels range from 0 to 120 for this example.
        let normalizedDecibels = min(max(decibels / 120.0, 0.0), 1.0)
        return Double(normalizedDecibels)
    }

    private func endLiveActivity() async {
        if #available(iOS 16.2, *) {
            if let currentActivity = activity {
                await currentActivity.end(nil,dismissalPolicy: .immediate)
                print("Ending the Live Activity: \(currentActivity.id)")
                // Activity 객체를 nil로 설정
                self.activity = nil
            }
        }
    }
}

#Preview {
    VoicePitchButton(action: { print("측정버튼을 클릭했습니다.")},
                     height: .constant(200),
                     noiseMeter: .constant(NoiseMeter()))
}
