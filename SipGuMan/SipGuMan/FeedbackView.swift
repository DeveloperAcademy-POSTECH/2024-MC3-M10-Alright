//
//  FeedbackView.swift
//  SipGuMan
//
//  Created by 이상도 on 7/25/24.
//

import SwiftUI

struct FeedbackView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("피드백 화면")
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("종료")
                    }
                }
            }
        }
    }
}

#Preview {
    FeedbackView()
}
