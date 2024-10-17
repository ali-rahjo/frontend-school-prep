import SwiftUI

struct ClassView: View {
    @StateObject private var particleSystem = ParticleSystemmm()

    var body: some View {
        ZStack {
            Image("slide8")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .ignoresSafeArea()

            Canvas { context, size in
                for particle in particleSystem.particles {
                    var contextCopy = context
                    let xPos = particle.x * size.width
                    let yPos = particle.y * size.height

                    contextCopy.translateBy(x: xPos, y: yPos)
                    contextCopy.rotate(by: particle.rotation)
                    contextCopy.scaleBy(x: particle.scale, y: particle.scale)

                    let star = createStarPath()
                    contextCopy.fill(star, with: .color(.white))
                }
            }
            .ignoresSafeArea()
            .onAppear {
                particleSystem.startShowering()
            }
            
            VStack {

                studentDetailsView()
            }
        }
    }
    
    private func studentDetailsView() -> some View {
        
        VStack {
            // Top buttons
            HStack {
                Button(action: {
                    // Action for Timetable button
                }) {
                    Text("Timetable")
                        .padding()
                        .frame(height: 70) // Increased button height
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Action for Lunch Menu button
                }) {
                    Text("Lunch Menu")
                        .padding()
                        .frame(height: 70) // Increased button height
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding(.top,10)

       

            // Bottom buttons
            HStack {
                Button(action: {
                    // Action for Announcement button
                }) {
                    Text("Updates")
                        .padding()
                        .frame(width: 120, height: 70) // Increased button height
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(1)
                }

                Button(action: {
                    // Action for Holiday button
                }) {
                    Text("Holiday")
                        .padding()
                        .frame(height: 70) // Increased button height
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(1)
                }
            }
            .padding(.top,20)
        }
        .frame(width: 350, height: 350)
        .background(Color.white.opacity(0.3))
        .padding(.bottom, 200)

    }

    private func createStarPath() -> Path {
        let star = Path { path in
            path.move(to: CGPoint(x: 0, y: -10))
            for angle in stride(from: 0.0, to: 360.0, by: 144.0) {
                let radians = angle * .pi / 180
                let point = CGPoint(x: 10 * cos(radians), y: 10 * sin(radians))
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
        return star
    }
}

class ParticleSystemmm: ObservableObject {
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
    ClassView()
}

