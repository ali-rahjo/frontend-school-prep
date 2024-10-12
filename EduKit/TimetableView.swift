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
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15)
                .shadow(color: Color.blue.opacity(0.5), radius: 5, x: 0, y: 5)
            
            // Periods arranged in a grid layout
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(periods) { period in
                    PeriodCardView(period: period)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}

struct PeriodCardView: View {
    var period: Period
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "book.fill") // Icon for the subject
                    .font(.title)
                    .foregroundColor(.white)
                Text("Period \(period.period)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            Text(period.subject)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(periodColor(for: period.subject))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
    
    private func periodColor(for subject: String) -> Color {
        
        switch subject {
        case "Deu": return Color.teal
        case "Ma": return Color.green
        case "Mittagessen": return Color.orange
        case "Mu": return Color.purple
        case "LBK/Eföb": return Color.pink
        case "Sa": return Color.yellow
        case "SozL Musik und Tanz": return Color.red
        case "Grisu Deu": return Color.mint
        case "Sp": return Color.indigo
        default: return Color.gray
        }
    }
}

