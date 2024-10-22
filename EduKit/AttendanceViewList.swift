import SwiftUI

struct Attendancee: Codable, Identifiable {
    let id: Int
    let student_id: Int
    let student_name: String
    let teacher_name: String
    let class_name: String
    let date: String
    let is_present: Bool
}

struct AttendanceViewList: View {
    
    var studentID: Int
    @State private var attendanceList: [Attendancee] = []
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
          
            Image("slide12")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()

            VStack {
                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if attendanceList.isEmpty {
                    Text("Loading attendance...")
                        .foregroundColor(.white)
                        .padding()
                } else {
                    
                    HStack {
                        Text("Attendance")
                            .font(.title)
                            .foregroundColor(.white)
                            
                       
                    }.padding(.top,70)
                        .padding(.leading,10)
                    
                    List(attendanceList) { attendance in
                        VStack(alignment: .leading, spacing: 10) {
                            
                           
                          
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    HStack {
                                        Text("Date")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(width: 180, alignment: .leading)
                                        Text(attendance.date)
                                            .foregroundColor(.orange)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    HStack {
                                        Text("Present")
                                            .font(.headline)
                                            .foregroundColor(Color(red: 202/255, green: 32/255, blue: 104/255))
                                            .frame(width: 180, alignment: .leading)
                                        Text(attendance.is_present ? "Yes" : "No")
                                            .foregroundColor(attendance.is_present ? .green : .red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    HStack {
                                        Text("Student")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(width: 180, alignment: .leading)
                                        Text(attendance.student_name.capitalized)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    HStack {
                                        Text("Teacher")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(width: 180, alignment: .leading)
                                        Text(attendance.teacher_name.capitalized)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    HStack {
                                        Text("Class")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(width: 180, alignment: .leading)
                                        Text(attendance.class_name.capitalized)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding()
                            }
                            .padding(.vertical, 5)
                        }
                        .listRowBackground(Color.clear)
                        .padding(.bottom,5)
                    }
                    .padding(.bottom,30)
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear {
                fetchAttendanceData()
            }
        }
    }

    func fetchAttendanceData() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/view/attendance/\(studentID)/") else {
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
                let attendanceResponse = try JSONDecoder().decode([Attendancee].self, from: data)
                DispatchQueue.main.async {
                    attendanceList = attendanceResponse
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

