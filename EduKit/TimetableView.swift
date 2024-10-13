import SwiftUI

struct TimetableView: View {
    
    var classID: Int
    @ObservedObject var viewModel: TimetableViewModel
    
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Timetable...")
                    .font(.headline)
                    .foregroundColor(.orange)
            } else if let timetable = viewModel.timetable {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(daysOfWeek, id: \.self) { day in
                            DayCardView(day: day, periods: timetable.timetableContent[day] ?? [])
                        }
                    }
                    .padding()
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .font(.title3)
            } else {
                Text("No timetable available.")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .background(   LinearGradient(
            gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                        Color(red: 0/255, green: 0/255, blue: 150/255)]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .onAppear {
            viewModel.fetchTimetable(classID: classID)
        }
        .navigationBarHidden(true)
        .font(.largeTitle)
        .foregroundColor(Color.pink)
    }
}

struct DayCardView: View {
    var day: String
    var periods: [Period]
    
    var body: some View {
        VStack {
            // Day header with playful background
            Text(day)
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.bottom,10)
              
            
            // Periods arranged in a grid layout
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(periods) { period in
                    PeriodCardView(period: period)
                }
            }
            .padding(.horizontal)
        }
      
        .shadow(color: Color.white.opacity(0.8), radius: 5, x: 0, y: 5)
        .padding(.bottom)
    }
}

struct PeriodCardView: View {
    var period: Period
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    // Gradient applied to the image
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0/255, green: 0/255, blue: 50/255),
                            Color(red: 0/255, green: 0/255, blue: 150/255)
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
                    .font(.headline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .shadow(color: Color.white.opacity(0.9), radius: 5, x: 0, y: 5)
                
            }
            
            Text(period.subject)
                .font(.subheadline)
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
        case "Sp": return Color.white
        default: return Color.white
        }
    }
}

