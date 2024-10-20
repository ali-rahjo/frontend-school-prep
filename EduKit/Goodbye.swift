import SwiftUI

struct Goodbye: View {
    @State private var bubbleCount = 100
    @State private var bubbleSizes: [CGFloat] = []
    @State private var bubbleOffsets: [CGFloat] = []

    var body: some View {
        ZStack {
            ForEach(0..<bubbleCount, id: \.self) { index in
                if index < bubbleSizes.count {
                    Circle()
                        .fill( Color(red: 113/255, green: 192/255, blue: 251/255))
                        .opacity(0.4)
                        .frame(width: bubbleSizes[index], height: bubbleSizes[index])
                        .offset(x: CGFloat.random(in: -150...150), y: bubbleOffsets[index])
                        .animation(.linear(duration: Double.random(in: 10...20))
                            .repeatForever(autoreverses: false), value: bubbleOffsets[index])
                        .onAppear {
                            animateBubble(index: index)
                           
                        }
                }
            }

            Text("See You Again!")
                .font(.custom("Noteworthy-Bold", size: 26))
                .fontWeight(.bold)
                .foregroundColor(Color.white.opacity(0.8))
                .padding()
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .onAppear {
            generateBubbleSizes()
            generateInitialOffsets()
        }
    }

    private func generateBubbleSizes() {
       
        bubbleSizes = (0..<bubbleCount).map { _ in CGFloat.random(in: 10...30) }
    }

    private func generateInitialOffsets() {
      
        bubbleOffsets = Array(repeating: 400, count: bubbleCount)
    }

    private func animateBubble(index: Int) {
        
        let duration = Double.random(in: 60...80)
        withAnimation(.linear(duration: duration)) {
            bubbleOffsets[index] = -500
        }

       
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            bubbleOffsets[index] = 400
            animateBubble(index: index)
        }
    }
}

struct Goodbye_Previews: PreviewProvider {
    static var previews: some View {
        Goodbye()
    }
}

