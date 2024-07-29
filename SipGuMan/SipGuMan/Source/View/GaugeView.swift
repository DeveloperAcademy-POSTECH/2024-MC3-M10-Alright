//
//  GaugeView.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/26/24.
//

import SwiftUI

enum GaugeColorLevel: String {
    case top
    case middle
    case bottom
}

struct GaugeView: View {
    
    @State private var gaugeHeight: Int = 444
    @Binding var noiseMeter: NoiseMeter
    
    private func getColor(decibels: Float, level: GaugeColorLevel) -> Color {
        let gaugeValue = gaugeHeight * Int(decibels) / 120
        
        let topStandard = gaugeHeight * 2 / 3
        let bottomStandard = gaugeHeight * 1 / 3
        
        switch level {
        case .top:
            if gaugeValue > topStandard {
                return Color(hex: "F8EDFF")
            } else if gaugeValue > bottomStandard {
                return Color(hex: "DDE2FF")
            } else {
                return Color(hex: "E3E8FF")
            }
        case .middle:
            if gaugeValue > topStandard {
                return Color(hex: "EDACFF")
            } else if gaugeValue > bottomStandard {
                return Color(hex: "91A3FF")
            } else {
                return Color(hex: "D9DFFF")
            }
        case .bottom:
            if gaugeValue > topStandard {
                return Color(hex: "CB75FF")
            } else if gaugeValue > bottomStandard {
                return Color(hex: "3D5CFF")
            } else {
                return Color(hex: "ADBAFF")
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                ZStack(alignment: .bottom){
                    Color.white
                        .clipShape(RoundedCorner(radius: 0,
                                                 corners: .allCorners))
                        .frame(width: 185, height: 444)
                    
                    GeometryReader { geometry in
                        VStack(spacing: 0) {
                            LinearGradient(
                                gradient: Gradient(colors: [getColor(decibels: noiseMeter.decibels,
                                                                     level: .top),
                                                            getColor(decibels: noiseMeter.decibels,
                                                                     level: .middle)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: geometry.size.height * 0.34)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [getColor(decibels: noiseMeter.decibels,
                                                                     level: .middle),
                                                            getColor(decibels: noiseMeter.decibels,
                                                                     level: .bottom)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: geometry.size.height * 0.66)
                        }
                    }
                    .clipShape(RoundedCorner(radius: 0,
                                             corners: .allCorners))
                    .frame(width: 185,
                           height: CGFloat(gaugeHeight * Int(noiseMeter.decibels) / 120))
                    .background(
                        Color.white
                            .clipShape(RoundedCorner(radius: 0,
                                                     corners: .allCorners))
                            .shadow(color: .white.opacity(0.25),
                                    radius: 8, x: 0, y: 0)
                    )
                    .animation(.easeInOut(duration: 0.5), value: noiseMeter.decibels)
                    
                }
                Rectangle()
                    .stroke(lineWidth: 1)
                    .frame(height:444/3)
                    .padding(.horizontal, -1)
            }
            .frame(width: 185, height: 444)
            .background(Color.black)
            .clipShape(RoundedCorner(radius: 24,
                                     corners: .allCorners))
            .shadow(color: .white.opacity(0.25), radius: 8, x: 0, y: 0)
        }
        .shadow(color: .white.opacity(0.25), radius: 8, x: 0, y: 0)
    }
    
}

#Preview {
    GaugeView(noiseMeter: .constant(NoiseMeter()))
}
