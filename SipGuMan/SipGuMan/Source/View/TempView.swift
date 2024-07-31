import SwiftUI

struct TempView: View {
    
    @State private var drawingHeight = true
    
    
    var body: some View {
        HStack(spacing: 2) {  // 막대 사이 간격을 좁게 설정
            bar(low: 0.4)
                .animation(animation.speed(1.5), value: drawingHeight)
            bar(low: 0.3)
                .animation(animation.speed(1.2), value: drawingHeight)
            bar(low: 0.5)
                .animation(animation.speed(1.0), value: drawingHeight)
            bar(low: 0.3)
                .animation(animation.speed(1.7), value: drawingHeight)
            bar(low: 0.5)
                .animation(animation.speed(1.0), value: drawingHeight)
        }
        .frame(width: 20, height: 20)  // compact 모드에 맞게 크기 조정
        .onAppear {
            withAnimation(animation) {
                drawingHeight.toggle()
            }
        }
    }
    
    var animation: Animation {
        .linear(duration: 0.5).repeatForever(autoreverses: true)
    }
    
    func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 1)  // 모서리 반경을 작게 설정
            .fill(Color.indigo)
            .frame(height: (drawingHeight ? high : low) * 20)  // compact 모드에 맞게 높이 조정
    }
}

#Preview {
    TempView()
}
