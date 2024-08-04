//
//  NoiseMeter.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/26/24.
//

import SwiftUI
import AVFoundation
import ActivityKit

@Observable
class NoiseMeter {
    
    let audioRecorder: AVAudioRecorder
    
    /// NoiseMeter - AVAudioRecorder를 위한 Timer
    var timer: Timer?
    
    /// NoiseMeter - LiveActivity update 주기(period) 부여를 위한 Timer
    var updateTimer: Timer?
    
    /// NoiseMeter - 현재 측정된 데시벨 크기
    var decibels: Float = 0
    
    /// NoiseMeter - 녹음 중인지 여부
    var isMeasuring: Bool {
        self.timer != nil
    }
    
    /// NoiseMeter - Live Activity의 Activity 객체
    var activity: Activity<DynamicIslandWidgetAttributes>?
    
    var nowSituation: String = ""
    
    init() {
        let audioFileURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0].appendingPathComponent(
            "audio.m4a"
        )
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        // AudioRecorder 객체 생성
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
        } catch let error {
            fatalError("Error creating audio recorder: \(error.localizedDescription)")
        }
    }
    
    /// 소리 측정 시작하는 함수
    func startMetering() async {
        do {
            try AVAudioSession.sharedInstance().setCategory(.record)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print("Error setting up audio session: \(error.localizedDescription)")
            return
        }
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.audioRecorder.updateMeters()
                let db = self.audioRecorder.averagePower(forChannel: 0)
                self.decibels = self.convertToDecibels(db)
            }
        }
    }
    
    /// 소리 측정 종료하는 함수
    func stopMetering() async {
        print(#function)
        audioRecorder.stop()
        timer?.invalidate()
        timer = nil
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: 1.0)) {
                self.decibels = 0
            }
        }
    }
    
    /// 소리 측정 On/Off 함수
    func measure() async {
        if self.timer == nil {
            await self.startMetering()
        } else {
            await self.stopMetering()
        }
    }
    
    /// 현재 dB의 100분율 계산 함수
    private func calculateProgress(for decibels: Float) -> Int {
        let normalizedDecibels = min(max(decibels / 120.0, 0.0), 1.0)
        return Int(normalizedDecibels * 100)
    }
    
    /// Live Activity를 실행하는 함수
    func startLiveActivity() {
        print(#function)
        if self.activity == nil {
            let noiseLevel = NoiseLevel.level(for: self.decibels, isMeasuring: self.isMeasuring)
            
            let attributes = DynamicIslandWidgetAttributes(name: "Alright")
            print(self.calculateProgress(for: decibels))
            let contentState = DynamicIslandWidgetAttributes.ContentState(
                decibels: Int(self.decibels),
                noiseLevel: noiseLevel,
                progress: self.calculateProgress(for: decibels),
                emoji: noiseLevel.emoji,
                title: self.nowSituation
            )
            let content = ActivityContent(state: contentState, staleDate: nil, relevanceScore: 1)
            
            do {
                self.activity = try Activity<DynamicIslandWidgetAttributes>.request(
                    attributes: attributes,
                    content: content,
                    pushType: nil
                )
            } catch {
                print("LiveActivityManager: Error in LiveActivityManager: \(error.localizedDescription)")
            }
        }
        
        updateTimer?.invalidate()
        var cancellation: Task<(), Never>?
        
        // TODO: - update 주기를 정확도와 연관지어 조절 기능 구현 및 timeInterval 픽스 필요.
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if cancellation != nil {
                cancellation?.cancel()
                cancellation = nil
            }
            cancellation = Task {
                await self.updateLiveActivity()
            }
        }
    }
    
    /// Live Activity를 종료하는 함수
    func endLiveActivity() async {
        print(#function)
        if let currentActivity = activity {
            await currentActivity.end(nil, dismissalPolicy: .immediate)
            print("Ending the Live Activity: \(currentActivity.id)")
            self.activity = nil
        }
        
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    /// Live Activity를 업데이트하는 함수
    func updateLiveActivity() async {
        print(#function)
        let noiseLevel = NoiseLevel.level(for: self.decibels, isMeasuring: self.isMeasuring)
        print(self.calculateProgress(for: decibels))
        let contentState = DynamicIslandWidgetAttributes.ContentState(
            decibels: Int(self.decibels),
            noiseLevel: noiseLevel,
            progress: calculateProgress(for: decibels),
            emoji: noiseLevel.emoji,
            title: self.nowSituation
        )
        await self.activity?.update(ActivityContent<DynamicIslandWidgetAttributes.ContentState>(
            state: contentState,
            staleDate: nil
        ))
    }
    
    // TODO: - 보정 알고리즘 개선 필요
    /// dB 보정하는 함수
    private func convertToDecibels(_ dbFS: Float) -> Float {
        let referenceLevel: Float = 94.0
        let dbSPL = dbFS + referenceLevel
        return max(min(max(dbSPL, 0.0), 120.0) - 10, 0)
    }
}
