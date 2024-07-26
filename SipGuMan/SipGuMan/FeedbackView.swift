
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
                    Text("피드백 화면")
                }
                Spacer()
                
                HStack {
                    Button {
                        voiceStarted.toggle()
                    } label: {
                        Text(voiceStarted ? "일시정지" : "시작")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.blue)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
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

//#Preview {
//    FeedbackView()
//}
