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
    
    var noiseLevel: NoiseLevel {
        NoiseLevel.level(for: noiseMeter.decibels,
                         isMeasuring: noiseMeter.isMeasuring)
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
                VoicePitchButton(noiseMeter: $noiseMeter)
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
