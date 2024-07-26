
import SwiftUI

struct FeedbackView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var voiceStarted = false
    
    @Binding var currentIndex: Int? // 현재 선택한 상황 index
    @Binding var currentSituation: String // 현재 선택한 상황
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("피드백 화면이 들어가는 곳입니다.")
                }
            }
            .navigationBarTitle("\(currentSituation)", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("종료")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    FeedbackView(
        currentIndex: .constant(0),
        currentSituation: .constant("원탁 회의")
    )
}
