//
//  SwiftUIView.swift
//  Alright
//
//  Created by 이상도 on 8/10/24.
//

import SwiftUI

enum Onboarding {
    case first, second, third, fourth
    
    var onboardingTitle: String {
        switch self {
        case .first:
            "Alright"
        case .second:
            "상황 선택"
        case .third:
            "실시간 피드백"
        case .fourth:
            "백그라운드"
        }
    }
    
    var onboardingConstants: String {
        switch self {
        case .first:
            "청각장애인의 목소리 크기 조절을\n도와드리는 앱 올라잇이에요."
        case .second:
            "대화, 발표 등 다양한 상황에 맞추어\n목소리 크기 조절을 도와드려요!"
        case .third:
            "애니메이션, 색상 등 시각적 피드백을 통해\n목소리 크기를 한 눈에 확인해요!"
        case .fourth:
            "Dynamic Island, Live Activity로\n다른 화면을 보며 모니터링 할 수 있어요!"
        }
    }
    
    var onboardingImage: Image {
        switch self {
        case .first:
            Image(.onboardingImage1)
        case .second:
            Image(.onboardingImage2)
        case .third:
            Image(.onboardingImage3)
        case .fourth:
            Image(.onboardingImage4)
        }
    }
}


