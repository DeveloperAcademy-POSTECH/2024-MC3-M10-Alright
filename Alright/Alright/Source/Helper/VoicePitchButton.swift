import SwiftUI
import ActivityKit

struct VoicePitchButton: View {
    
    @Binding var noiseMeter: NoiseMeter
    var body: some View {
        Button {
            // 측정 버튼이 눌릴 때 현재 noiseLevel을 계산하고 출력합니다.
            handleButtonTap()
            Task {
                await noiseMeter.measure()
            }
        } label: {
            Image(noiseMeter.isMeasuring ? "pause" : "record")
        }
        // noiseMeter의 decibels 값이 변경될 때마다 noiseLevel을 업데이트하고 출력합니다.
    }
    
    /// 버튼 클릭
    private func handleButtonTap() {
        if !noiseMeter.isMeasuring {
            // 측정을 시작하고 라이브 액티비티 시작
            noiseMeter.startLiveActivity()
        } else {
            // 측정을 멈추고 라이브 액티비티 종료
            Task {
                await noiseMeter.endLiveActivity()
                // 측정을 멈추는 작업을 여기에 추가
            }
        }
    }
}

#Preview {
    VoicePitchButton(noiseMeter: .constant(NoiseMeter()))
}
