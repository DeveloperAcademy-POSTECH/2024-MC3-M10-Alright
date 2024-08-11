//
//  ContentView.swift
//  Alright
//
//  Created by 윤동주 on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLottieViewShown = true
    
    var body: some View {
        VStack {
            if isLottieViewShown {
                LottieView()
                    .opacity(isLottieViewShown ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.linear(duration: 1.0)) {
                                isLottieViewShown = false
                            }
                        }
                    }
            } else {
                SelectionView()
            }
        }
        .background(.sgmGray2)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
