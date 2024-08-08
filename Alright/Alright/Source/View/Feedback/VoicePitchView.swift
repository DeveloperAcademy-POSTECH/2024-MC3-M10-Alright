//
//  VoicePitchView.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/25/24.
//

import SwiftUI
import AVFoundation
import ActivityKit

struct VoicePitchView: View {
    
    @Binding var noiseMeter: NoiseMeter
    @Binding var currentSituation: Situation?
    
    var noiseLevel: NoiseLevel {
        NoiseLevel.level(for: noiseMeter.decibels,
                         isMeasuring: noiseMeter.isMeasuring,
                         standard: noiseMeter.nowSituation?.decibels ?? (0, 0))
    }
    
    var body: some View {
        ZStack {
            Color.sgmGray2
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 45)
                HStack(spacing: 8) {
                    Text("\(noiseLevel.emoji)")
                    Text("\(noiseLevel.message)")
                        .font(.Pretendard.SemiBold.size20)
                        .kerning(-0.4)
                        .foregroundStyle(.sgmWhite)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(noiseLevel.textBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.sgmWhite, lineWidth: 1)
                }
                Spacer()
                    .frame(height: 40)
                GaugeView(noiseMeter: $noiseMeter,
                          currentSituation: $currentSituation)
                
                Spacer()
                    .frame(height: 32)
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(String(format: "%.0f", noiseMeter.decibels))")
                        .font(.Pretendard.SemiBold.size24)
                        .foregroundStyle(.white)
                        .frame(width: 35)
                        .kerning(-0.4)
                    
                    Text("dB")
                        .font(.Pretendard.Regular.size16)
                        .foregroundStyle(.white)
                        .padding(.bottom, 2)
                        .kerning(-0.4)
                }
                Spacer()
                    .frame(height: 32)
                VoicePitchButton(noiseMeter: $noiseMeter)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//#Preview {
//    VoicePitchView(measure: {
//
//    },
//                   activity: .constant(nil),
//                   noiseMeter: .constant(NoiseMeter()))
//}
