//
//  ContentView.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("현재 어떤 상황이세요?")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                Spacer()
                
                Button {
                    print("피드백 시각화화면으로 이동")
                } label: {
                    Text("1:1 상황")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
