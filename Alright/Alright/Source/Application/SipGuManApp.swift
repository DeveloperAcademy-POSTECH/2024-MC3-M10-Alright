//
//  SipGuManApp.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/25/24.
//

import SwiftUI
import DotLottie

@main
struct SipGuManApp: App {
    
    @State private var isLottieViewShown = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                SelectionView()
                
                if isLottieViewShown {
                    LottieView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation(.easeOut(duration: 1.0)) {
                                    isLottieViewShown = false
                                }
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
