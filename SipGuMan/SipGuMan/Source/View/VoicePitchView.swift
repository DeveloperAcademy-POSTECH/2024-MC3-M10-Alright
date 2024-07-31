//
//  VoicePitchView.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/25/24.
//

import SwiftUI
import AVFoundation

struct VoicePitchView: View {
    
    @State private var noiseMeter = NoiseMeter()
    @State private var circleHeight: CGFloat = 0
    
    var isMeasuring: Bool {
        self.noiseMeter.timer != nil
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                GaugeView(noiseMeter: $noiseMeter)
                
                Spacer()
                
                Text(NoiseLevel.message(for: noiseMeter.decibels,
                                        isMeasuring: noiseMeter.isMeasuring))
                .foregroundStyle(Color(hex: "AAAAAA"))
                
                Spacer()
                
                Text("\(String(format: "%.2f", noiseMeter.decibels))dB")
                    .foregroundStyle(.white)
                VoicePitchButton(action: { Task { await measure(height: circleHeight) } },
                                 height: $circleHeight,
                                 noiseMeter: $noiseMeter)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear{
            Task {
                await measure(height: circleHeight)
            }
        }
    }
    
    private func measure(height: CGFloat) async {
        if noiseMeter.timer == nil {
            await noiseMeter.startMetering()
        } else {
            await noiseMeter.stopMetering()
        }
    }
}

enum NoiseLevel: String {
    case low = "목소리를 조금 더 크게 내보세요!"
    case medium = "적정한 목소리 크기로 말하고 계시네요!"
    case high = "목소리를 조금 더 작게 내보는게 어떨까요?"
    case notMeasuring = "다시 시작하려면 버튼을 탭하세요!"
    
    var emoji: String {
        switch self {
        case .low:
            return "🫥"
        case .medium:
            return "👍🏻"
        case .high:
            return "😖"
        case .notMeasuring:
            return "🔇"
        }
    }
    
    static func level(for decibels: Float, isMeasuring: Bool) -> NoiseLevel {
        guard isMeasuring else {
            return .notMeasuring
        }
        
        let level = decibels / 120.0
        
        switch level {
        case _ where level > 7.0 / 12.0:
            return .high
        case _ where level > 5.0 / 12.0:
            return .medium
        default:
            return .low
        }
    }
    
    static func message(for decibels: Float, isMeasuring: Bool) -> String {
        return level(for: decibels, isMeasuring: isMeasuring).rawValue
    }
}


#Preview {
    VoicePitchView()
}
