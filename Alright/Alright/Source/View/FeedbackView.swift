
import SwiftUI
import ActivityKit

struct FeedbackView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var noiseMeter = NoiseMeter()
    @State private var activity: Activity<DynamicIslandWidgetAttributes>?
    
    // 선택한 상황에 따라서 currentIndex(0~3)에 맞춰서 데시벨 다르게
    @Binding var currentIndex: Int? // 현재 선택한 상황 index
    @Binding var currentSituation: String // 현재 선택한 상황
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sgmGray2
                    .ignoresSafeArea()
                
                VoicePitchView(measure: measure, 
                               activity: $activity,
                               noiseMeter: $noiseMeter)
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(currentSituation)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // 측정을 멈추고 라이브 액티비티 종료
                            if noiseMeter.isMeasuring {
                                Task {
                                    await endLiveActivity()
                                }
                            }
                            dismiss()
                        } label: {
                            Text("종료")
                                .foregroundColor(.sgmBlue1) // 종료 버튼 색상 변경
                        }
                    }
                }
            }
            .onAppear{
                Task {
                    await measure()
                }
            }
        }
    }
    
    private func measure() async {
        if noiseMeter.timer == nil {
            await noiseMeter.startMetering()
        } else {
            await noiseMeter.stopMetering()
        }
    }
    
    private func endLiveActivity() async {
        if let currentActivity = activity {
            await currentActivity.end(nil,dismissalPolicy: .immediate)
            print("Ending the Live Activity: \(currentActivity.id)")
            // Activity 객체를 nil로 설정
            self.activity = nil
            self.noiseMeter.timer = nil
        }
    }
    
}


#Preview {
    FeedbackView(
        currentIndex: .constant(0),
        currentSituation: .constant("원탁 회의")
    )
}
