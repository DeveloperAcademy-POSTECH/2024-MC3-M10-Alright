//
//  TipSheetView.swift
//  Alright
//
//  Created by 이상도 on 8/8/24.
//

import SwiftUI

struct InfoSheetView: View {
    
    @Binding var isShowing: Bool
    @Binding var nowSituation: Situation?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.6)
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
                
                VStack(spacing: 0) {
                    Divider()
                        .frame(width:64, height: 4)
                        .background(.sgmBlue3)
                        .cornerRadius(4)
                        .padding(.top)
                    Spacer()
                    
                    HStack {
                        Text("스마트폰의 위치를 설정해주세요!".localized())
                            .font(.Pretendard.SemiBold.size22)
                            .foregroundColor(.white)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top, 5)
                    .padding(.bottom)
                    
                    HStack {
                        Text("\(nowSituation?.infoMessage ?? "")")
                            .font(.Pretendard.Medium.size18)
                            .foregroundColor(.white)
                            .lineSpacing(4)
                            .padding(.leading)
                        Spacer()
                    }
                    Spacer()
                    
                    Button {
                        isShowing = false
                    } label: {
                        Text("확인".localized())
                            .font(.Pretendard.SemiBold.size17)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                                LinearGradient(
                                    gradient: .init(colors: [Color(hex: "#394999"),
                                                             Color(hex: "#4C61CC"),
                                                             Color(hex: "#6079FF")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 222)
                .background(.sgmGray3)
                .cornerRadius(16)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}
