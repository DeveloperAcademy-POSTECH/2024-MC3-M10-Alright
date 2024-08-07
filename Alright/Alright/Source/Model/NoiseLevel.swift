//
//  NoiseLevel.swift
//  Alright
//
//  Created by 윤동주 on 8/2/24.
//

import SwiftUI

enum NoiseLevel: String, Codable {
    case low, medium, high, notMeasuring
    
    static func level(for decibels: Float,
                      isMeasuring: Bool,
                      standard: (Int, Int)) -> NoiseLevel {
        guard isMeasuring else {
            return .notMeasuring
        }
        let level = decibels / 120.0
        
        switch level {
        case _ where level > Float(standard.1) / 120.0:
            return .high
        case _ where level > Float(standard.0) / 120.0:
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
            return "조금 더 크게 말해볼까요?"
        case .medium:
            return "좋아요. 적절해요!"
        case .high:
            return "조금 더 작게 말하는게 어떨까요?"
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
                gradient: Gradient(stops: [
                    .init(color: .sgmDBs1, location: 0.0),
                    .init(color: .sgmDBs2, location: 0.34),
                    .init(color: .sgmDBs3, location: 1.0)
                ]),
                startPoint: .trailing,
                endPoint: .leading
            )
        case .medium:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .sgmDBm1, location: 0.0),
                    .init(color: .sgmDBm2, location: 0.34),
                    .init(color: .sgmDBm3, location: 1.0)
                ]),
                startPoint: .trailing,
                endPoint: .leading
            )
        case .high:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .sgmDBlg1, location: 0.0),
                    .init(color: .sgmDBlg2, location: 0.34),
                    .init(color: .sgmDBlg3, location: 1.0)
                ]),
                startPoint: .trailing,
                endPoint: .leading
            )
        case .notMeasuring:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .black, location: 0.0),
                    .init(color: .black, location: 0.34),
                    .init(color: .black, location: 1.0)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
    
    var noiseBorderGradientColor: LinearGradient {
        switch self {
        case .low:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .sgmDBs1, location: 0.0),
                    .init(color: .sgmDBs2, location: 0.34),
                    .init(color: .sgmDBs3, location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .medium:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .sgmDBm1, location: 0.0),
                    .init(color: .sgmDBm2, location: 0.34),
                    .init(color: .sgmDBm3, location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .high:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .sgmDBlg1, location: 0.0),
                    .init(color: .sgmDBlg2, location: 0.34),
                    .init(color: .sgmDBlg3, location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .notMeasuring:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .black, location: 0.0),
                    .init(color: .black, location: 0.34),
                    .init(color: .black, location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
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
