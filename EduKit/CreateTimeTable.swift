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
    @State private var timetable: [DayInput] = []
    
    var classId: Int
    var teacherId: Int
    @State private var isSuccess: Bool = false

    init(classId: Int, teacherId: Int) {
        self.classId = classId
        self.teacherId = teacherId
        self._timetable = State(initialValue: CreateTimeTable.createDays())
    }

    var body: some View {
        ZStack {
            Image("slide11")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()
               
               

            ScrollView {
                VStack {
                    Text("Create Timetable")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)

                    ForEach(timetable) { dayInput in
                        VStack(alignment: .leading) {
                            Text(dayInput.day)
                                .font(.custom("Noteworthy-Bold", size: 24))
                                .padding(.top)
                                .foregroundColor(.white)

                            
                            VStack {
                            ForEach(dayInput.periods) { period in
                                HStack {
                                    Text("Period \(period.period)").foregroundColor(.black)
                                    TextField("Enter subject", text: Binding(
                                        get: { period.subject },
                                        set: { newSubject in
                                            if let index = timetable.firstIndex(where: { $0.id == dayInput.id }),
                                               let periodIndex = timetable[index].periods.firstIndex(where: { $0.id == period.id }) {
                                                timetable[index].periods[periodIndex].subject = newSubject
                                            }
                                        }
                                    ))
                                    .opacity(0.3)
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading, 10)
                                }
                                .padding(.horizontal)
                            }
                        }
                            .padding()
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(10)
                            .padding(.bottom)
                        }
                    }
                    
                    Button(action: createTimetable) {
                        Text("Submit")
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top, 20)
                            .cornerRadius(10)
                    }
                    .fontWeight(.bold)
                    
                    if isSuccess {
                        Text("Timetable created successfully!")
                            .foregroundColor(.green)
                            .padding()
                    }
                }
                .padding(.top, 50)
                .padding(.bottom, 100)
                .padding()
            }
        }
    }
    
   
    static func createPeriods() -> [PeriodInput] {
        return (1...6).map { PeriodInput(period: $0, subject: "") }
    }

  
    static func createDays() -> [DayInput] {
        let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        return days.map { DayInput(day: $0, periods: createPeriods()) }
    }
    
    func createTimetable() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/timetable/create/\(classId)/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

       
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
        
        timetable = CreateTimeTable.createDays()
        isSuccess = false
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}

