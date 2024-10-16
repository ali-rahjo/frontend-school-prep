import SwiftUI

struct StudentProfile: View {
    
    @StateObject private var viewModel = StudentProfileViewModel()
    @StateObject private var particleSystem = ParticleSystemm()
    
    var body: some View {
        ZStack {
            // Background Image
            Image("slide8")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .ignoresSafeArea()
            
            // Particle System
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
            
            // Main Content
            VStack {
                headerView
                
                Spacer(minLength: 20)
                
                if let student = viewModel.student {
                    profileDetailsView(for: student)
                }
                
                Spacer()
                
                // Loading Indicator or Alert
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                        .scaleEffect(1.5)
                } else if viewModel.showAlert {
                    Text(viewModel.alertMessage)
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding()
                }
            }
            .padding(.bottom, 10)
        }
        .onAppear {
            viewModel.fetchStudentProfile()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private var headerView: some View {
        HStack {
            Image("logo2")
                .resizable()
                .frame(width: 65, height: 75)
                .foregroundColor(.white)
                .padding(.leading, 100)
            
            if let student = viewModel.student {
                Text("\(student.first_name.capitalized) \(student.last_name.capitalized)")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                    .font(.custom("Noteworthy-Bold", size: 36))
            }
            Spacer()
        }
    }
    
    private func profileDetailsView(for student: Students) -> some View {
        VStack {
            Text("**Age**: \(student.age)")
            Text("**Username**: \(student.username)")
            Text("**Gender**: \(student.gender == "M" ? "Male" : "Female")")
            
            Text("**Class Information**")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
            Text("Class Name: \(student.class_info.class_name)")
            Text("Grade: \(student.class_info.grade)")
            Text("Academic Year: \(student.class_info.academic_year_start) - \(student.class_info.academic_year_end)")
            
            Text("**Teacher Information**")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
            Text("Teacher Name: \(student.teacher_info.user.first_name) \(student.teacher_info.user.last_name)")
            Text("Teacher Username: \(student.teacher_info.user.username)")
            Text("Teacher Gender: \(student.teacher_info.gender == "M" ? "Male" : "Female")")
            Text("Date Joined: \(formattedDate(student.teacher_info.user.date_joined))")
        }
        .frame(width: 350, height: 450)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal, 40)
        .padding(.bottom, 100)
    }
    
    // Create star path
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
    
    // Helper function to format date strings
    func formattedDate(_ isoDateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: isoDateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return isoDateString
    }
}

class ParticleSystemm: ObservableObject {
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
    StudentProfile()
}

