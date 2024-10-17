import SwiftUI

struct Attendance: Identifiable, Decodable {
    let id: Int
    let studentId: Int
    let studentName: String
    let teacherName: String
    let className: String
    let date: String
    let isPresent: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case studentId = "student_id"
        case studentName = "student_name"
        case teacherName = "teacher_name"
        case className = "class_name"
        case date
        case isPresent = "is_present"
    }
}

struct TeacherAttendanceList: View {
    @State private var attendanceRecords: [Attendance] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("slide11")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else if isLoading {
                        Text("Loading attendance...")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        Text("Attendance List")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, -40)
                            .padding(.leading, 10)

                        List(attendanceRecords) { record in
                            VStack(alignment: .leading) {
                                Text(record.studentName.capitalized)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))

                                HStack {
                                    Text("Class")
                                        .font(.headline)
                                        .frame(width: 100, alignment: .leading)
                                        .foregroundColor(Color.white)
                                    Text("\(record.className.capitalized)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.white)
                                }
                                .padding(.top,1)
                                
                                HStack {
                                    Text("Date")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .frame(width: 100, alignment: .leading)
                                    Text("\(record.date.capitalized)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.mint)
                                        .fontWeight(.bold)
                                }

                                HStack {
                                    Text("Present")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .frame(width: 100, alignment: .leading)
                                    Text("\(record.isPresent ? "Yes" : "No")")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(record.isPresent ? .green : .red)
                                        .fontWeight(.bold)
                                }
                                
                                Divider()
                                           .background(Color.white)
                                           .padding(.vertical, 10)
                            }
                            .padding(.bottom, 10)
                            .listRowBackground(Color.clear)
                        }
                        .padding(.top, 10)
                        .listStyle(PlainListStyle())
                    }
                }
                .padding(.top, 70) // Prevent UI elements from overlapping with the safe area
                .onAppear(perform: loadAttendanceData)
            }
        }
    }

    private func loadAttendanceData() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/attendance/view/") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                    self.isLoading = false
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                attendanceRecords = try decoder.decode([Attendance].self, from: data)
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
            DispatchQueue.main.async {
                isLoading = false
            }
        }
        task.resume()
    }
}

struct TeacherAttendanceList_Previews: PreviewProvider {
    static var previews: some View {
        TeacherAttendanceList()
    }
}

