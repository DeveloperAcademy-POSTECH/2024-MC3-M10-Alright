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
                
                GaugeView(noiseMeter: $noiseMeter,
                          currentSituation: $currentSituation)
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(String(format: "%.0f", noiseMeter.decibels))")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 40)
                    
                    Text("dB")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(.bottom, 2)
                }
                Spacer()
                
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
