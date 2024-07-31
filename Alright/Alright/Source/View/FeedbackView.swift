
import SwiftUI

struct FeedbackView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // 선택한 상황에 따라서 currentIndex(0~3)에 맞춰서 데시벨 다르게
    @Binding var currentIndex: Int? // 현재 선택한 상황 index
    @Binding var currentSituation: String // 현재 선택한 상황
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sgmGray2
                    .ignoresSafeArea()
                
                VoicePitchView()
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
                            dismiss()
                        } label: {
                            Text("종료")
                                .foregroundColor(.sgmBlue1) // 종료 버튼 색상 변경
                        }
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
