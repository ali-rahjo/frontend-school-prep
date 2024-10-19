


import SwiftUI


struct Timetableresponsee: Codable {
    let id: Int
    let timetableContent: [String: [TimetableEntryy]]
    let teacher: Int
    let classID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case timetableContent = "timetable_content"
        case teacher
        case classID = "class_id"
    }
}

struct TimetableEntryy: Codable, Identifiable {
    let id = UUID()
    let period: Int
    let subject: String
}

struct TeacherTimeTable: View {
    
    @StateObject private var particleSystem = ParticleSyste()
    var classId: Int
    @State private var timetable: [String: [TimetableEntryy]] = [:]
    @State private var isLoading = false
    @State private var errorMessage: String?
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]


    var body: some View {
        NavigationView {
            
            ZStack {
             
                Image("slide11")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                
            
            ScrollView {
                VStack(spacing: 20) {
                    if isLoading {
                        ProgressView("Loading timetable...")
                            .progressViewStyle(CircularProgressViewStyle())
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        ForEach(daysOfWeek, id: \.self) { day in
                            if let periods = timetable[day] {
                                TeacherDayView(day: day, periods: periods)
                            } else {
                                TeacherDayView(day: day, periods: [])
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
        isLoading = true
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/timetable/view/\(classId)/") else { return }
        
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
                let decodedResponse = try JSONDecoder().decode([Timetableresponsee].self, from: data)
                if let firstTimetable = decodedResponse.first {
                    DispatchQueue.main.async {
                        self.timetable = firstTimetable.timetableContent
                        self.isLoading = false
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
}


struct TeacherDayView: View {
    
    var day: String
    var periods: [TimetableEntryy]
    
    var body: some View {
        VStack {
           
            Text(day)
                .font(.custom("Noteworthy-Bold", size: 20))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                .cornerRadius(15)
                .padding(.bottom, 10)
            
          
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(periods) { period in
                    PeriodcardVieww(period: period)
                }
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.white.opacity(0.8), radius: 5, x: 0, y: 5)
        .padding(.bottom)
        .padding(.top)
       
    }
}

struct PeriodcardVieww: View {
    var period: TimetableEntryy
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 202 / 255, green: 32 / 255, blue: 104 / 255),
                            Color(red: 202 / 255, green: 32 / 255, blue: 104 / 255)
                            
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



