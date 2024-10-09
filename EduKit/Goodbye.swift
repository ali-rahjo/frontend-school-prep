import SwiftUI

struct Goodbye: View {
    @State private var bubbleCount = 10 // Number of bubbles
    @State private var bubbleSizes: [CGFloat] = [] // Array to hold bubble sizes

    var body: some View {
        ZStack {
            // Display bubbles
            ForEach(0..<bubbleCount, id: \.self) { index in
                if index < bubbleSizes.count { // Check index bounds to avoid out of range
                    Circle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(width: bubbleSizes[index], height: bubbleSizes[index])
                        .offset(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: -150...150))
                        .animation(.easeInOut(duration: 2)
                            .repeatForever(autoreverses: true), value: bubbleSizes[index])
                }
            }
            Text("Goodbye!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .onAppear {
            // Generate bubble sizes when the view appears
            generateBubbleSizes()
            animateBubbles()
        }
    }
    
    private func generateBubbleSizes() {
        // Generate random sizes for bubbles
        bubbleSizes = (0..<bubbleCount).map { _ in CGFloat.random(in: 30...80) }
    }
    
    private func animateBubbles() {
        for index in 0..<bubbleCount {
            withAnimation {
                bubbleSizes[index] = CGFloat.random(in: 40...80) // Randomize bubble size
            }
        }
    }
}



struct Logout_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Logout()
        }
    }
}

