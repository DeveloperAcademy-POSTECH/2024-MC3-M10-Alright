//
//  SheetLottieView.swift
//  Alright
//
//  Created by 이상도 on 9/16/24.
//

import SwiftUI
import DotLottie

struct SheetLottieView: View {
    @State private var animation: DotLottieAnimation = DotLottieAnimation(fileName: "alertLottieScreen", config: AnimationConfig(autoplay: true, loop: true))
    var body: some View {
        animation.view()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all) // 상태 바 및 안전 영역 무시
    }
}

#Preview {
    SheetLottieView()
}
