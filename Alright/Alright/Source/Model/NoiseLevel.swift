//
//  NoiseLevel.swift
//  Alright
//
//  Created by 윤동주 on 8/2/24.
//

import SwiftUI

enum NoiseLevel: String, Codable {
    case low, medium, high, notMeasuring
    
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
            return "👍"
        case .high:
            return "😮"
        case .notMeasuring:
            return "🔇"
        }
    }
    
    var imageString: String {
        switch self {
        case .low:
            return "smallGraYellow"
        case .medium:
            return "smallGraBlue"
        case .high:
            return "smallGraRed"
        case .notMeasuring:
            return "nothingHalfCircle"
        }
    }
    
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
    
    var noiseGradientColor: LinearGradient {
        switch self {
        case .low:
            return LinearGradient(
                gradient: Gradient(colors: [.sgmDBs1, .sgmDBs3]),
                startPoint: .trailing,
                endPoint: .leading
            )
        case .medium:
            return LinearGradient(
                gradient: Gradient(colors: [.sgmDBm1, .sgmDBm3]),
                startPoint: .trailing,
                endPoint: .leading
            )
        case .high:
            return LinearGradient(
                gradient: Gradient(colors: [.sgmDBlg1, .sgmDBlg3]),
                startPoint: .trailing,
                endPoint: .leading
            )
        case .notMeasuring:
            return LinearGradient(
                gradient: Gradient(colors: [.black, .black.opacity(0.6)]),
                startPoint: .trailing,
                endPoint: .leading
            )
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
