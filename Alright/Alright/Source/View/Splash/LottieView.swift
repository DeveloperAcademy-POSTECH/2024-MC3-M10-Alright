//
//  LottieView.swift
//  Alright
//
//  Created by 윤동주 on 8/7/24.
//

import SwiftUI
import DotLottie

struct LottieView: View {
    
    @State private var animation: DotLottieAnimation = DotLottieAnimation(fileName: "splashScreen", config: AnimationConfig(autoplay: true, loop: false))
    var body: some View {
        animation.view()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all) // 상태 바 및 안전 영역 무시
    }
}

#Preview {
    LottieView()
}
