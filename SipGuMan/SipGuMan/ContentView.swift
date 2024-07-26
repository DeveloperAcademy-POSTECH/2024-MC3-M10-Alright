
import SwiftUI

struct ContentView: View {
    
    @State private var isNavigating = false // Navigation Bool
    
    @State var situation: [String] = ["1:1 대화", "원탁 회의", "회의실 발표", "강당 발표"]
    @State private var selectedIndex: Int? = nil // 상황4개중 선택 index
    @State private var selectedSituation: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    Text("지금 어떤 상황에 있나요?")
                        .font(.system(size: 24, weight: .bold))
                    
                    Text("말하는 상황에 대해 알려주세요.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                Spacer()
                
                HStack(spacing: 10) {
                    ZStack {
                        CustomRectangle(selected: selectedIndex == 0)
                        VStack {
                            HStack {
                                Text("\(situation[0])")
                                    .font(.system(size: 22, weight: .semibold))
                                    .padding(.leading)
                                Spacer()
                            }
                            Image(systemName: "house")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .padding(.leading, 50)
                        }
                    }
                    .onTapGesture {
                        handleSelection(index: 0)
                    }
                    
                    ZStack {
                        CustomRectangle(selected: selectedIndex == 1)
                        VStack {
                            HStack {
                                Text("\(situation[1])")
                                    .font(.system(size: 22, weight: .semibold))
                                    .padding(.leading)
                                Spacer()
                            }
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .padding(.leading, 50)
                        }
                    }
                    .onTapGesture {
                        handleSelection(index: 1)
                    }
                }
                .padding(.horizontal, 20)
                
                HStack(spacing: 10) {
                    ZStack {
                        CustomRectangle(selected: selectedIndex == 2)
                        VStack {
                            HStack {
                                Text("\(situation[2])")
                                    .font(.system(size: 22, weight: .semibold))
                                    .padding(.leading)
                                Spacer()
                            }
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .padding(.leading, 50)
                        }
                    }
                    .onTapGesture {
                        handleSelection(index: 2)
                    }
                    
                    ZStack {
                        CustomRectangle(selected: selectedIndex == 3)
                        VStack {
                            HStack {
                                Text("\(situation[3])")
                                    .font(.system(size: 22, weight: .semibold))
                                    .padding(.leading)
                                Spacer()
                            }
                            Image(systemName: "rays")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .padding(.leading, 50)
                        }
                    }
                    .onTapGesture {
                        handleSelection(index: 3)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                if selectedIndex != nil {
                    Button {
                        isNavigating.toggle()
                        print("피드백 시각화화면으로 이동")
                    } label: {
                        Text("말하기시작")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                    }
                    .navigationDestination(isPresented: $isNavigating) {
                        FeedbackView(currentIndex: $selectedIndex, currentSituation: $selectedSituation)
                    }
                }
                Spacer()
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
            }
            selectedSituation = ""
        }
    }
}

// Rectangle View
struct CustomRectangle: View {
    
    var selected: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(selected ? .yellow : .white)
                .frame(maxWidth: .infinity, maxHeight: 160)
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(selected ? .blue : .black, lineWidth: 1)
                )
        }
    }
}

#Preview {
    ContentView()
}
