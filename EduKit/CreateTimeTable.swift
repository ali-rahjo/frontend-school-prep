import SwiftUI

struct PeriodInput: Identifiable {
    let id = UUID()
    var period: Int
    var subject: String
}

struct DayInput: Identifiable {
    let id = UUID()
    var day: String
    var periods: [PeriodInput]
}

struct CreateTimeTable: View {
    @State private var timetable: [DayInput] = [
        DayInput(day: "Monday", periods: [
            PeriodInput(period: 1, subject: ""),
            PeriodInput(period: 2, subject: ""),
            PeriodInput(period: 3, subject: ""),
            PeriodInput(period: 4, subject: ""),
            PeriodInput(period: 5, subject: ""),
            PeriodInput(period: 6, subject: "")
        ]),
        DayInput(day: "Tuesday", periods: [
            PeriodInput(period: 1, subject: ""),
            PeriodInput(period: 2, subject: ""),
            PeriodInput(period: 3, subject: ""),
            PeriodInput(period: 4, subject: ""),
            PeriodInput(period: 5, subject: ""),
            PeriodInput(period: 6, subject: "")
        ]),
        DayInput(day: "Wednesday", periods: [
            PeriodInput(period: 1, subject: ""),
            PeriodInput(period: 2, subject: ""),
            PeriodInput(period: 3, subject: ""),
            PeriodInput(period: 4, subject: ""),
            PeriodInput(period: 5, subject: ""),
            PeriodInput(period: 6, subject: "")
        ]),
        DayInput(day: "Thursday", periods: [
            PeriodInput(period: 1, subject: ""),
            PeriodInput(period: 2, subject: ""),
            PeriodInput(period: 3, subject: ""),
            PeriodInput(period: 4, subject: ""),
            PeriodInput(period: 5, subject: ""),
            PeriodInput(period: 6, subject: "")
        ]),
        DayInput(day: "Friday", periods: [
            PeriodInput(period: 1, subject: ""),
            PeriodInput(period: 2, subject: ""),
            PeriodInput(period: 3, subject: ""),
            PeriodInput(period: 4, subject: ""),
            PeriodInput(period: 5, subject: ""),
            PeriodInput(period: 6, subject: "")
        ])
    ]
    
    var classId: Int
    var teacherId: Int
    @State private var isSuccess: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                Text("Create Timetable")
                    .font(.largeTitle)
                    .padding()

                ForEach(timetable.indices, id: \.self) { dayIndex in
                    VStack(alignment: .leading) {
                                            Text(timetable[dayIndex].day)
                                                .font(.headline)
                                                .padding(.top)
                        
                        ForEach(timetable[dayIndex].periods.indices, id: \.self) { index in
                            HStack {
                                Text("Period \(timetable[dayIndex].periods[index].period):")
                                TextField("Enter subject", text: $timetable[dayIndex].periods[index].subject)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading, 10)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                Button(action: createTimetable) {
                    Text("Submit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
                
                if isSuccess {
                    Text("Timetable created successfully!")
                        .foregroundColor(.green)
                        .padding()
                }
            }
            .padding()
        }
    }
    
    func createTimetable() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/timetable/create/\(classId)/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare the JSON body for the entire week
        var timetableContent: [String: [[String: Any]]] = [:]
        
        for dayInput in timetable {
            timetableContent[dayInput.day] = dayInput.periods.map { ["period": $0.period, "subject": $0.subject] }
        }
        
        let requestBody: [String: Any] = [
            "class_id": classId,
            "teacher": teacherId,
            "timetable_content": timetableContent
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                               if let error = error {
                                   print("Error creating timetable: \(error.localizedDescription)")
                                  
                                   self.showAlert(title: "Error", message: "Failed to create timetable.")
                                   return
                               }

                               if let data = data {
                                   print("Timetable response: \(String(describing: String(data: data, encoding: .utf8)))")
                                   playSound(sound: "sound-rise", type: "mp3")
                                   feedback.notificationOccurred(.success)
                                   self.showAlert(title: "Success", message: "Timetable created successfully!")
                                   self.resetFields()
                               }
                           }
            }.resume()
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
        }
    }
    
    private func resetFields() {
            // Reset the timetable to its initial state
            timetable = [
                DayInput(day: "Monday", periods: [
                    PeriodInput(period: 1, subject: ""),
                    PeriodInput(period: 2, subject: ""),
                    PeriodInput(period: 3, subject: ""),
                    PeriodInput(period: 4, subject: ""),
                    PeriodInput(period: 5, subject: ""),
                    PeriodInput(period: 6, subject: "")
                ]),
                DayInput(day: "Tuesday", periods: [
                    PeriodInput(period: 1, subject: ""),
                    PeriodInput(period: 2, subject: ""),
                    PeriodInput(period: 3, subject: ""),
                    PeriodInput(period: 4, subject: ""),
                    PeriodInput(period: 5, subject: ""),
                    PeriodInput(period: 6, subject: "")
                ]),
                DayInput(day: "Wednesday", periods: [
                    PeriodInput(period: 1, subject: ""),
                    PeriodInput(period: 2, subject: ""),
                    PeriodInput(period: 3, subject: ""),
                    PeriodInput(period: 4, subject: ""),
                    PeriodInput(period: 5, subject: ""),
                    PeriodInput(period: 6, subject: "")
                ]),
                DayInput(day: "Thursday", periods: [
                    PeriodInput(period: 1, subject: ""),
                    PeriodInput(period: 2, subject: ""),
                    PeriodInput(period: 3, subject: ""),
                    PeriodInput(period: 4, subject: ""),
                    PeriodInput(period: 5, subject: ""),
                    PeriodInput(period: 6, subject: "")
                ]),
                DayInput(day: "Friday", periods: [
                    PeriodInput(period: 1, subject: ""),
                    PeriodInput(period: 2, subject: ""),
                    PeriodInput(period: 3, subject: ""),
                    PeriodInput(period: 4, subject: ""),
                    PeriodInput(period: 5, subject: ""),
                    PeriodInput(period: 6, subject: "")
                ])
            ]
            
           
          
            isSuccess = false
        }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert on the main thread
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}

