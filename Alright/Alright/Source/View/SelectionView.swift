import SwiftUI
import AVFoundation

struct SelectionView: View {
    
    @State private var isNavigating = false // Navigation Bool
    
    @State var situation: [String] = ["1:1 대화", "1:1 대화", "회의실 발표", "강당 발표"]
    @State private var selectedIndex: Int? = nil // 상황4개중 선택 index
    @State private var selectedSituation: String = "" // 선택한 상황
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sgmGray2
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
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
                        ZStack {
                            SelectionRectangle(selected: selectedIndex == 0)
                            
                            VStack {
                                HStack {
                                    Text("\(situation[0])")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .semibold))
                                        .padding(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text("조용한 공간에서")
                                        .foregroundColor(.sgmGrayA)
                                        .font(.system(size: 12, weight: .regular))
                                        .padding(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Image("onebyone")
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .padding(.trailing)
                                }
                            }
                        }
                        .onTapGesture {
                            handleSelection(index: 0)
                        }
                        
                        ZStack {
                            SelectionRectangle(selected: selectedIndex == 1)
                            VStack {
                                HStack {
                                    Text("\(situation[1])")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .semibold))
                                        .padding(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text("소음이 있는 공간에서")
                                        .foregroundColor(.sgmGrayA)
                                        .font(.system(size: 12, weight: .regular))
                                        .padding(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Image("roundTable")
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .padding(.trailing)
                                }
                            }
                        }
                        .onTapGesture {
                            handleSelection(index: 1)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 10) {
                        ZStack {
                            SelectionRectangle(selected: selectedIndex == 2)
                            VStack(spacing: 20) {
                                HStack {
                                    Text("\(situation[2])")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .semibold))
                                        .padding(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Image("conference")
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .padding(.trailing)
                                }
                            }
                        }
                        .onTapGesture {
                            handleSelection(index: 2)
                        }
                        
                        ZStack {
                            SelectionRectangle(selected: selectedIndex == 3)
                            VStack(spacing: 20) {
                                HStack {
                                    Text("\(situation[3])")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .semibold))
                                        .padding(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Image("presentation")
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .padding(.trailing)
                                }
                            }
                        }
                        .onTapGesture {
                            handleSelection(index: 3)
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
                    .opacity(selectedIndex != nil ? 1 : 0) // 상황 고르면 실제로 보이도록
                    .navigationDestination(isPresented: $isNavigating) {
                        FeedbackView(currentIndex: $selectedIndex, currentSituation: $selectedSituation)
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
    
    private func handleSelection(index: Int) {
        if selectedIndex == nil { // 현재 상황을 선택한게 없다면
            selectedIndex = index
            selectedSituation = situation[index]
        } else { // 상황을 선택한게 있다면
            if selectedIndex == index { // 같은 상황 또 선택시
                selectedIndex = nil // 선택 취소
            } else {
                selectedIndex = index // 다른 상황으로 선택으로
                selectedSituation = situation[index]
            }
        }
    }
}

#Preview {
    SelectionView()
}
