//
//  FeedbackView.swift
//  SipGuMan
//
//  Created by 이상도 on 7/25/24.
//

import SwiftUI

struct FeedbackView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var voiceStarted = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("피드백 화면")
                }
                Spacer()
                
                HStack {
                    Button {
                        voiceStarted.toggle()
                    } label: {
                        Text(voiceStarted ? "일시정지" : "시작")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
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
