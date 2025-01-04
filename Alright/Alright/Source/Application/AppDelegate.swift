//
//  AppDelegate.swift
//  Alright
//
//  Created by 이상도 on 1/4/25.
//

import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // 앱이 종료될때 실행
    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
        NoiseMeter.shared.endLiveActivity()
        print("[앱 강제종료 됨 : endLiveActivity Done]")
    }
}
