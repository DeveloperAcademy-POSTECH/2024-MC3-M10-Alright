import SwiftUI
import AVFoundation

struct SelectionView: View {
    
    @AppStorage("isFirstOnboarding") var isFirstOnboarding: Bool = true // 앱 Onboarding
    @AppStorage("isCompletedOnboarding") var isCompletedOnboarding: Bool = true // 도움말 Onboarding
    
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
                    VStack(spacing: 12) {
                        Text("지금 어떤 상황에 있나요?")
                            .font(.Pretendard.Bold.size24)
                            .foregroundColor(.white)
                        
                        Text("말하는 상황에 대해 알려주세요.")
                            .font(.Pretendard.Medium.size16)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                        .frame(height: 104)
                    VStack(spacing: 9) {
                        HStack(spacing: 9) {
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
                        
                        HStack {
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
                    }
                    Spacer()
                    
                    Button {
                        isNavigating.toggle()
                        print("피드백 시각화화면으로 이동")
                    } label: {
                        Text("말하기 시작")
                            .font(.Pretendard.SemiBold.size17)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                                LinearGradient(
                                    gradient: .init(colors: [Color(hex: "#394999"),
                                                             Color(hex: "#4C61CC"),
                                                             Color(hex: "#6079FF")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .opacity(selectedSituation != nil ? 1 : 0) // 상황 고르면 실제로 보이도록
                    .navigationDestination(isPresented: $isNavigating) {
                        FeedbackView(currentSituation: $selectedSituation)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isFirstOnboarding = true // 온보딩은 띄우면서, isCompletedOnboarding은 false로
                        isCompletedOnboarding = false
                    } label: {
                        Text("도움말")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.sgmGrayA)
                    }
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
        .fullScreenCover(isPresented: $isFirstOnboarding) {
            AppOnboardingView(isFirstOnboarding: $isFirstOnboarding, isCompletedOnboarding: $isCompletedOnboarding)
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
