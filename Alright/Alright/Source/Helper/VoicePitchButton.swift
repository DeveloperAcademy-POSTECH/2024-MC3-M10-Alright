//
//  VoicePitchButton.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/25/24.
//

import SwiftUI

struct VoicePitchButton: View {
    
    let action: () -> Void
    
    @Binding var height: CGFloat
    @Binding var noiseMeter: NoiseMeter
    
    var body: some View {
        Button {
            action()
        } label: {
            Button {
                action()
            } label: {
                Image(noiseMeter.isMeasuring ? "pause" : "record")
            }
        }
    }
}

#Preview {
    VoicePitchButton(action: { print("측정버튼을 클릭했습니다.")},
                     height: .constant(200),
                     noiseMeter: .constant(NoiseMeter()))
}
