//
//  Situation.swift
//  Alright
//
//  Created by 윤동주 on 8/7/24.
//

import SwiftUI

enum Situation {
    case quietTalking, loudTalking, meetingRoom, auditorium
    
    var title: String {
        switch self {
        case .quietTalking:
            "1:1 대화"
        case .loudTalking:
            "1:1 대화"
        case .meetingRoom:
            "회의실 발표"
        case .auditorium:
            "강당 발표"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .quietTalking:
            "조용한 공간에서"
        case .loudTalking:
            "소음이 있는 공간에서"
        case .meetingRoom:
            nil
        case .auditorium:
            nil
        }
    }
    
    var image: Image {
        switch self {
        case .quietTalking:
            Image(.onebyone)
        case .loudTalking:
            Image(.roundTable)
        case .meetingRoom:
            Image(.conference)
        case .auditorium:
            Image(.presentation)
        }
    }
    
    var decibels: (Int, Int) {
        switch self {
        case .quietTalking:
            (53, 75)
        case .loudTalking:
            (58, 80)
        case .meetingRoom:
            (68, 78)
        case .auditorium:
            (65, 75)
        }
    }
}
