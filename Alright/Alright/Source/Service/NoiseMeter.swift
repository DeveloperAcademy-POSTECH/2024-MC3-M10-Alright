//
//  NoiseMeter.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/26/24.
//

import SwiftUI
import AVFoundation

@Observable
class NoiseMeter {
    
    let audioRecorder: AVAudioRecorder
    var timer: Timer?
    var decibels: Float = 0
    
    var isMeasuring: Bool {
        self.timer != nil
    }
    
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
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
        } catch let error {
            fatalError("Error creating audio recorder: \(error.localizedDescription)")
        }
    }
    
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
    
    func stopMetering() async {
        timer?.invalidate()
        timer = nil
        withAnimation(.easeOut(duration: 1.0)) {
            self.decibels = 0
        }
        audioRecorder.stop()
    }
    
    private func convertToDecibels(_ dbFS: Float) -> Float {
        
        let referenceLevel: Float = 94.0
        
        let dbSPL = dbFS + referenceLevel
        
        return max(min(max(dbSPL, 0.0), 120.0) - 10, 0)
    }
}
    
