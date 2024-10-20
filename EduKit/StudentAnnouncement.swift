

import SwiftUI

struct Announcementtt: Codable, Identifiable {
let id: Int
let date: String
let announcement: String

}

struct StudentAnnouncement: View {

@State private var announcements: [Announcementtt] = []
@State private var errorMessage: String?
@StateObject private var particleSystem = ParticleSystemmmm()

var body: some View {
ZStack {
 
    Image("slide8")
        .resizable()
        .scaledToFill()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
        if let errorMessage = errorMessage {
            Text("Error: \(errorMessage)")
                .foregroundColor(.red)
                .padding()
        } else if announcements.isEmpty {
            Text("Loading announcements...")
                .foregroundColor(.white)
                .padding()
        } else {
            
            HStack {
                Text("Announcements")
                    .font(.title)
                    .foregroundColor(.white)
                    
               
            }.padding(.top,50)
                .padding(.leading,40)
            
            List(announcements) { announcement in
                VStack(alignment: .leading, spacing: 10) {
                    Text(announcement.date)
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    Text(announcement.announcement)
                        .foregroundColor(.white)
                        .font(.custom("Noteworthy-Bold", size: 18))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.6))
                )
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
        }
    }.padding(.top,20)
        .padding(.bottom,50)
    .onAppear {
        fetchAnnouncements()
    }
}
}

func fetchAnnouncements() {
guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/view/announcement") else {
    errorMessage = "Invalid URL"
    return
}

URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        DispatchQueue.main.async {
            errorMessage = "Error fetching data: \(error.localizedDescription)"
        }
        return
    }
    
    guard let data = data else {
        DispatchQueue.main.async {
            errorMessage = "No data received"
        }
        return
    }
    
    do {
        let announcementResponse = try JSONDecoder().decode([Announcementtt].self, from: data)
        DispatchQueue.main.async {
            announcements = announcementResponse
        }
    } catch {
        DispatchQueue.main.async {
            errorMessage = "Error decoding data: \(error.localizedDescription)"
        }
    }
}.resume()
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

class ParticleSystemmmm: ObservableObject {
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



