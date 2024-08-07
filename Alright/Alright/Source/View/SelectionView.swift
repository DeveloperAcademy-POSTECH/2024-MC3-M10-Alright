import SwiftUI
import AVFoundation

struct SelectionView: View {
    
    @State private var isNavigating = false // Navigation Bool
    @State private var selectedSituation: Situation?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sgmGray2
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                        .frame(height: 101)
                    VStack(spacing: 10) {
                        Text("지금 어떤 상황에 있나요?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("말하는 상황에 대해 알려주세요.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    HStack(spacing: 10) {
                        SelectionRectangle(situation: .quietTalking,
                                           currentSituation: selectedSituation)
                        .onTapGesture {
                            handleSelection(situation: .quietTalking)
                        }
                        
                        SelectionRectangle(situation: .loudTalking,
                                           currentSituation: selectedSituation)
                        .onTapGesture {
                            handleSelection(situation: .loudTalking)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 10) {
                        SelectionRectangle(situation: .meetingRoom,
                                           currentSituation: selectedSituation)
                        .onTapGesture {
                            handleSelection(situation: .meetingRoom)
                        }
                        
                        SelectionRectangle(situation: .auditorium,
                                           currentSituation: selectedSituation)
                        .onTapGesture {
                            handleSelection(situation: .auditorium)
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    
                    Button {
                        isNavigating.toggle()
                        print("피드백 시각화화면으로 이동")
                    } label: {
                        Text("말하기 시작")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                                LinearGradient(
                                    gradient: .init(colors: [.sgmBlue2, .sgmBlue1]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                    }
                    .opacity(selectedSituation != nil ? 1 : 0) // 상황 고르면 실제로 보이도록
                    .navigationDestination(isPresented: $isNavigating) {
                        FeedbackView(currentSituation: $selectedSituation)
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            let recordingSession = AVAudioSession.sharedInstance()
            do {
                try recordingSession.setCategory(AVAudioSession.Category.playAndRecord,
                                                 mode: .default,
                                                 policy: .default)
                
                try recordingSession.setActive(true)
            } catch {
                print("Cannot setup the Recording")
            }
        }
    }
    
    private func handleSelection(situation: Situation) {
        if selectedSituation == situation {
            selectedSituation = nil
        } else {
            selectedSituation = situation
        }
    }
}

#Preview {
    SelectionView()
}
