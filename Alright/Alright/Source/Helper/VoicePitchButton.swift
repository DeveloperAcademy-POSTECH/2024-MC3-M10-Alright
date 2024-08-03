import SwiftUI
import ActivityKit

struct VoicePitchButton: View {
    
    @Binding var noiseMeter: NoiseMeter
    var body: some View {
        Button {
            recordButtonTapped()
        } label: {
            Image(noiseMeter.isMeasuring ? "pause" : "record")
        }
    }
    
    /// 소리 측정 On/Off 버튼 클릭 함수
    private func recordButtonTapped() {
        
        // 소리 측정 On/Off
        Task {
            await noiseMeter.measure()
        }
        
        // 소리 측정 중 여부에 따라 Live Activity 활성화 여부 결정
        if !noiseMeter.isMeasuring {
            noiseMeter.startLiveActivity()
        } else {
            // 측정을 멈추고 라이브 액티비티 종료
            Task {
                await noiseMeter.endLiveActivity()
            }
        }
    }
}

#Preview {
    VoicePitchButton(noiseMeter: .constant(NoiseMeter()))
}
