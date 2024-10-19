import SwiftUI

// Define a model to match the structure of the API response
struct Timetableresponse: Codable {
    let id: Int
    let timetableContent: [String: [TimetableEntry]]
    let teacher: Int
    let classID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case timetableContent = "timetable_content"
        case teacher
        case classID = "class_id"
    }
}

struct TimetableEntry: Codable, Identifiable {
    let id = UUID()
    let period: Int
    let subject: String
}

struct ChildrenTimeTable: View {
    
    @StateObject private var particleSystem = ParticleSyste()
    var classID: Int
    @State private var timetable: [String: [TimetableEntry]] = [:]
    @State private var isLoading = false
    @State private var errorMessage: String?
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]


    var body: some View {
        NavigationView {
            
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
                
            
            ScrollView {
                VStack(spacing: 20) {
                    if isLoading {
                        ProgressView("Loading timetable...") // Loading indicator
                            .progressViewStyle(CircularProgressViewStyle())
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        ForEach(daysOfWeek, id: \.self) { day in
                            if let periods = timetable[day] {
                                SubjectDayView(day: day, periods: periods)
                            } else {
                                SubjectDayView(day: day, periods: [])
                            }
                        }
                        
                    }
                }
                .padding(.top,50)
                .padding()
            }
            .padding(.bottom,30)
            .onAppear(perform: fetchTimetable)
            }
        }
    }
    
    func fetchTimetable() {
        isLoading = true // Start loading
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/student/view/timetable/\(classID)/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed to load timetable: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "No data received"
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode([Timetableresponse].self, from: data)
                if let firstTimetable = decodedResponse.first {
                    DispatchQueue.main.async {
                        self.timetable = firstTimetable.timetableContent
                        self.isLoading = false // Stop loading
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Error decoding data: \(error.localizedDescription)"
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

class ParticleSyste: ObservableObject {
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



struct SubjectDayView: View {
    var day: String
    var periods: [TimetableEntry]
    
    var body: some View {
        VStack {
            // Day header with playful background
            Text(day)
                .font(.custom("Noteworthy-Bold", size: 20))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(15)
                .padding(.bottom, 10)
            
            // Periods arranged in a grid layout
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(periods) { period in
                    PeriodcardView(period: period)
                }
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 0, y: 5)
        .padding(.bottom)
        .padding(.top)
        .background(Color.white.opacity(0.3))
    }
}

struct PeriodcardView: View {
    var period: TimetableEntry // Updated to match the model
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black,
                            Color.black
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .mask(
                        Image(systemName: "book.fill")
                            .font(.title)
                    )
                }
                
                Text("Period \(period.period)")
                    .font(.custom("Noteworthy-Bold", size: 18))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .shadow(color: Color.white.opacity(0.9), radius: 5, x: 0, y: 5)
               
            }
            
            Text(period.subject)
                .font(.custom("Noteworthy-Bold", size: 16))
                .foregroundColor(.black)
        }
        .padding()
        .background(periodColor(for: period.subject))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
    
    private func periodColor(for subject: String) -> Color {
        switch subject {
        case "Deu": return Color.white
        case "Ma": return Color.white
        case "Mittagessen": return Color.white
        case "Mu": return Color.white
        case "LBK/Eföb": return Color.white
        case "Sa": return Color.white
        case "SozL Musik und Tanz": return Color.white
        case "Grisu Deu": return Color.white
        case "Grisu Ma": return Color.white
        case "Sp": return Color.white
        case "Ku": return Color.white
        default: return Color.white
        }
    }
}


// Preview for SwiftUI
struct ChildrenTimeTable_Previews: PreviewProvider {
    static var previews: some View {
        ChildrenTimeTable(classID: 1)
    }
}

