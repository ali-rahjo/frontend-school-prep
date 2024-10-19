import SwiftUI

struct CreateLunchMenu: View {
    @State private var weekStartDate = ""
    @State private var weekEndDate = ""
    @State private var mondayMenu = ["", "", "", ""]
    @State private var tuesdayMenu = ["", "", "", ""]
    @State private var wednesdayMenu = ["", "", "", ""]
    @State private var thursdayMenu = ["", "", "", ""]
    @State private var fridayMenu = ["", "", "", ""]
    
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            Image("slide11")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()
            
            VStack {
                Text("Create Lunch Menu")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 60)
                    .padding(.bottom,5)
                
                Form {
                    Section(header: Text("Week")
                        .foregroundColor(.black)
                        .font(.custom("Noteworthy-Bold", size: 14))) {
                        TextField("Week Start Date (YYYY-MM-DD)", text: $weekStartDate)
                        TextField("Week End Date (YYYY-MM-DD)", text: $weekEndDate)
                        }.padding(.top,20)
                      
                    
                    Section(header: Text("Monday")
                        .foregroundColor(.black)
                        .font(.custom("Noteworthy-Bold", size: 14))) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("Dish \(index + 1)", text: $mondayMenu[index])
                        }
                    }
                    
                    Section(header: Text("Tuesday")
                        .foregroundColor(.black)
                        .font(.custom("Noteworthy-Bold", size: 14))) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("Dish \(index + 1)", text: $tuesdayMenu[index])
                        }
                    }
                    
                    Section(header: Text("Wednesday")
                        .foregroundColor(.black)
                        .font(.custom("Noteworthy-Bold", size: 14))) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("Dish \(index + 1)", text: $wednesdayMenu[index])
                        }
                    }
                    
                    Section(header: Text("Thursday")
                        .foregroundColor(.black)
                        .font(.custom("Noteworthy-Bold", size: 14))) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("Dish \(index + 1)", text: $thursdayMenu[index])
                        }
                    }
                    
                    Section(header: Text("Friday")
                        .foregroundColor(.black)
                        .font(.custom("Noteworthy-Bold", size: 14))) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("Dish \(index + 1)", text: $fridayMenu[index])
                        }
                    }
                    
                    Button(action: submitLunchMenu) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .fontWeight(.bold)
                            .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                            .cornerRadius(10)
                    }.padding(.bottom,30)
                } .background(Color.black.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.top,10)
                    .padding()
                
                .padding(.horizontal, 10)
            }.background(Color.black.opacity(0.4))
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Submission Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func submitLunchMenu() {
        let lunchMenu = [
            "Monday": mondayMenu,
            "Tuesday": tuesdayMenu,
            "Wednesday": wednesdayMenu,
            "Thursday": thursdayMenu,
            "Friday": fridayMenu
        ]
        
        let lunchMenuData: [String: Any] = [
            "week_start_date": weekStartDate,
            "week_end_date": weekEndDate,
            "lunch_menu": [
                "Week 1": lunchMenu
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: lunchMenuData, options: []) else {
            self.alertMessage = "Error converting data to JSON"
            self.showingAlert = true
            return
        }
        
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/lunchmenu/create/") else {
            self.alertMessage = "Invalid URL"
            self.showingAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "Error occurred: \(error.localizedDescription)"
                    self.showingAlert = true
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.alertMessage = "Invalid response received"
                    self.showingAlert = true
                }
                return
            }
            
            if let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                DispatchQueue.main.async {
                    self.alertMessage = "Menu successfully submitted!"
                    self.showingAlert = true
                }
                print("Response from server: \(jsonResponse)")
            }
        }
        
        task.resume()
    }
}

#Preview {
    CreateLunchMenu()
}

