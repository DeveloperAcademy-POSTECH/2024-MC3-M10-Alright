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
    
    var noiseLevel: NoiseLevel {
        NoiseLevel.level(for: noiseMeter.decibels,
                              isMeasuring: isMeasuring)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("\(noiseLevel.emoji) \(noiseLevel.message)")
                    .foregroundStyle(.sgmWhite)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(noiseLevel.textBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .strokeBorder(.sgmWhite, lineWidth: 1)
                    }
                Spacer()
                
                GaugeView(noiseMeter: $noiseMeter)
                
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

enum NoiseLevel: String, Codable {
    case low, medium, high, notMeasuring
    
    var message: String {
        switch self {
        case .low:
            return "목소리를 조금 더 크게 내보세요!"
        case .medium:
            return "적정한 목소리 크기로 말하고 계시네요!"
        case .high:
            return "목소리를 조금 더 작게 내보는게 어떨까요?"
        case .notMeasuring:
            return "다시 시작하려면 버튼을 탭하세요!"
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
    
    var emoji: String {
        switch self {
        case .low:
            return "🤔"
        case .medium:
            return "👍🏻"
        case .high:
            return "😮"
        case .notMeasuring:
            return "🔇"
        }
    }
    
    var imageString: String {
        switch self {
        case .low:
            return "yellowHalfCircle"
        case .medium:
            return "blueHalfCircle"
        case .high:
            return "redHalfCircle"
        case .notMeasuring:
            return "nothingHalfCircle"
        }
    }
    
    var noiseColor: Color {
        switch self {
        case .low:
            return .sgmDBs2
        case .medium:
            return .sgmDBm2
        case .high:
            return .sgmDBlg2
        case .notMeasuring:
            return .black
        }
    }
    
    var textBackgroundColor: Color {
        switch self {
        case .low:
            return .sgmYellow0
        case .medium:
            return .sgmBlue0
        case .high:
            return .sgmRed0
        case .notMeasuring:
            return .black
        }
    }
}


#Preview {
    VoicePitchView()
}
