import SwiftUI

struct ContentView: View {
    
    @StateObject private var particleSystem = ParticleSystem()
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 0) {
                
                ZStack {
                    Image("slide12")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                    
                    // Text and logo elements
                    Text("SchoolPrep")
                        .font(.custom("Noteworthy-Bold", size: 60))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 200)
                    
                    Text("Genie")
                        .font(.custom("Bradley Hand", size: 46))
                        .foregroundColor(Color.white)
                        .padding(.leading, 100)
                        .padding(.bottom, 100)
                    
                    Image("logo2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 85)
                        .clipShape(Circle())
                        .padding(.top, 60)
                    
                    // White stars animation
                    Canvas { context, size in
                        for particle in particleSystem.particles {
                            var contextCopy = context
                            let xPos = particle.x * size.width
                            let yPos = particle.y * size.height
                            
                            contextCopy.translateBy(x: xPos, y: yPos)
                            contextCopy.rotate(by: particle.rotation)
                            contextCopy.scaleBy(x: particle.scale, y: particle.scale)
                            
                            let star = Path { path in
                                path.move(to: CGPoint(x: 0, y: -10))
                                for angle in stride(from: 0.0, to: 360.0, by: 144.0) {
                                    let radians = angle * .pi / 180
                                    let point = CGPoint(x: 10 * cos(radians), y: 10 * sin(radians))
                                    path.addLine(to: point)
                                }
                                path.closeSubpath()
                            }
                            contextCopy.fill(star, with: .color(.white))
                        }
                    }
                    .ignoresSafeArea()
                    .onAppear {
                        particleSystem.startShowering()
                    }
                }
                .background(Color(red: 164/255, green: 223/255, blue: 239/255))
                
                // Navigation Links
                HStack {
                    NavigationLink(destination: AboutUsView()) {
                        Text("About Us")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: LoginSelection()) {
                        Text("Home")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: ContactUsView()) {
                        Text("Contact Us")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .background(Color.black)
                .edgesIgnoringSafeArea(.horizontal)
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

class ParticleSystem: ObservableObject {
    struct Particle {
        var x: Double
        var y: Double
        var scale: Double
        var rotation: Angle
        var velocity: Double
    }
    
    @Published var particles = [Particle]()
    
    func startShowering() {
        particles = (0..<100).map { _ in
            Particle(x: Double.random(in: 0...1),
                     y: Double.random(in: -0.2...1.0),
                     scale: Double.random(in: 0.1...0.5),
                     rotation: Angle.degrees(Double.random(in: 0...360)),
                     velocity: Double.random(in: 0.001...0.005))
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateParticles()
        }
    }
    
    private func updateParticles() {
        for i in 0..<particles.count {
            particles[i].y += particles[i].velocity
            if particles[i].y > 1.1 {
                particles[i].y = -0.1
                particles[i].x = Double.random(in: 0...1)
                particles[i].velocity = Double.random(in: 0.02...0.1)
            }
        }
    }
}





#Preview {
    ContentView()
}

