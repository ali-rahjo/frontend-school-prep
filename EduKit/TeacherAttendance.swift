import SwiftUI

struct Studentlist: Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    var isPresent: Bool? = nil // Default is nil
    var attendanceDate: String? = nil
}

struct TeacherAttendance: View {
    
    @State private var students: [Studentlist] = []
    @State private var className: String = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("slide11")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
                
                VStack {
                    if className.isEmpty {
                        Text("Class Name not found or empty")
                            .font(.headline)
                            .padding()
                    } else {
                        Text("\(className.capitalized)")
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(.white)
                    }
                    
                    List($students) { $student in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(student.id)")
                                    .font(.headline)
                                
                                Text("\(student.firstName.capitalized) \(student.lastName.capitalized)")
                                    .font(.custom("Optima", size: 16))
                                
                                Spacer()
                                
                                Picker("", selection: Binding(
                                    get: {
                                        student.isPresent == true ? "Present" : (student.isPresent == false ? "Absent" : "")
                                    },
                                    set: { newValue in
                                        markAttendance(for: student.id, isPresent: newValue == "Present")
                                    }
                                )) {
                                    Text("Present")
                                        .tag("Present")
                                        .background(Color.green)
                                    Text("Absent")
                                        .tag("Absent")
                                        .background(Color.red)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .disabled(student.isPresent != nil)
                            }
                            
                            if let attendanceDate = student.attendanceDate {
                                Text("Date: \(attendanceDate)")
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .onAppear(perform: loadData)
            }
        }
    }
    
    func loadData() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/students/") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // Print raw response for debugging
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response: \(jsonString)")
                    }
                    
                    // Parse JSON
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    var loadedStudents: [Studentlist] = []
                    
                    json?.forEach { studentDict in
                        if let id = studentDict["id"] as? Int,
                           let firstName = studentDict["first_name"] as? String,
                           let lastName = studentDict["last_name"] as? String,
                           let classInfo = studentDict["class_info"] as? [String: Any],
                           let className = classInfo["class_name"] as? String {
                            
                            if self.className.isEmpty {
                                self.className = className
                                print("Class Name: \(className)")
                            }
                            
                            let student = Studentlist(id: id, firstName: firstName, lastName: lastName)
                            loadedStudents.append(student)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        students = loadedStudents
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            } else if let error = error {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    func markAttendance(for studentID: Int, isPresent: Bool) {
            guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/attendance/mark/\(studentID)/") else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = ["is_present": isPresent]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            isLoading = true
            print("Request Body: \(body)")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    isLoading = false // Ensure loading is turned off in UI on main thread
                }
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response: \(jsonString)") // Raw response for debugging
                    }
                    
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let studentID = jsonResponse["student_id"] as? Int,
                       let isPresent = jsonResponse["is_present"] as? Bool,
                       let attendanceDate = jsonResponse["date"] as? String {
                        
                        print("Updated attendance for student ID \(studentID): Present = \(isPresent)")
                        
                        // Updating the student's attendance info
                        DispatchQueue.main.async {
                            if let index = students.firstIndex(where: { $0.id == studentID }) {
                                students[index].isPresent = isPresent
                                students[index].attendanceDate = attendanceDate
                                
                                // Force UI to refresh
                                // No need to force UI to refresh like this, simply modifying the struct should work
                            }
                        }
                    }
                } catch {
                    print("Error processing the response: \(error.localizedDescription)")
                }
            }.resume()
        }
    

}

