import SwiftUI

struct TeacherProfile: View {
    
    @State private var isMenuOpen = false
    @State private var isLoading = true
    @State private var teacherProfile: [String: Any] = [:]
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
           
            if isLoading {
                           
                            VStack {
                                ProgressView("Loading...")
                                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                                    .scaleEffect(1.5)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .navigationBarHidden(true)
            } else {
            
            
                VStack {
                   
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 43/255, green: 7/255, blue: 105/255),
                                Color(red: 124/255, green: 18/255, blue: 106/255),
                                Color(red: 180/255, green: 27/255, blue: 107/255)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )

                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 300)

                        VStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                            

                            
                            if let user = teacherProfile["user"] as? [String: Any],
                                    let firstName = user["first_name"] as? String,
                                    let lastName = user["last_name"] as? String {
                                    Text("\(firstName.capitalized) \(lastName.capitalized)")
                                    .font(.title)
                                    .foregroundColor(.white)
                            } else {
                                    Text("Anna Avetisyan")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 10)
                    } .padding(.top, 0)

                    Form {
                        
                        HStack {
                            Image(systemName: "tag")
                                .foregroundColor(.pink)
                                .opacity(0.8)
                            if let id = teacherProfile["id"] as? Int {
                                   Text("\(id)")
                               } else {
                                   Text("0")
                               }
                            Spacer()
                        }

                        
                        
                        
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.pink)
                                .opacity(0.8)
                            if let user = teacherProfile["user"] as? [String: Any],
                                let username = user["username"] as? String {
                                Text(username)
                            } else {
                                Text("Anna Avetisyan")
                            }
                            Spacer()
                        }

                       

                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.pink)
                                .opacity(0.8)
                            if let gender = teacherProfile["gender"] as? String {
                                Text(gender == "M" ? "Male" : (gender == "F" ? "Female" : "Unknown"))
                            } else {
                                Text("M")
                            }
                            
                            Spacer()
                        }


                        
                        HStack {
                                Image(systemName: "calendar")
                                .foregroundColor(.pink)
                                .opacity(0.8)
                                if let user = teacherProfile["user"] as? [String: Any],
                                   let dateJoined = user["date_joined"] as? String {
                                    let formattedDate = formatDate(dateString: dateJoined)
                                    Text(formattedDate)
                                } else {
                                    Text("Date not available")
                                }
                                Spacer()
                            }
                        
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.pink)
                                .opacity(0.8)
                            Text("Password")
                            Spacer()
                        }

                      
                        Button(action: {
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        }) {
                            Text("Edit Profile")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 43/255, green: 7/255, blue: 105/255),
                                        Color(red: 124/255, green: 18/255, blue: 106/255),
                                        Color(red: 180/255, green: 27/255, blue: 107/255)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                    }
                    .padding(.top, -10)
                }
                
               
                .offset(x: isMenuOpen ? 250 : 0)
                .animation(.easeInOut, value: isMenuOpen)
            }

           
            if isMenuOpen {
                
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }

              
                TeacherSideMenu()
                    .frame(width: 270)
                    .background(Color.gray.opacity(0.9))
                   
                    .offset(x: isMenuOpen ? -80 : -100)
                    .animation(.easeInOut, value: isMenuOpen)
                    

            }
        }
        
        .toolbar {
                   ToolbarItemGroup(placement: .navigationBarLeading) {
                       
                     
                      
                       VStack {
                         
                          
                           Button(action: {
                               withAnimation {
                                   isMenuOpen.toggle()
                               }
                           }) {
                               Image(systemName: "line.horizontal.3")
                                   .font(.title)
                                   .foregroundColor(.white)
                           }
                       }
                   }
               }
        .navigationBarBackButtonHidden(isMenuOpen)
        .onAppear {
                   
                    TeacherProfileService.shared.getTeacherProfile { result in
                        switch result {
                        case .success(let profile):
                            DispatchQueue.main.async {
                                self.teacherProfile = profile
                                self.isLoading = false
                            }
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                            self.isLoading = false
                            alertMessage = error.localizedDescription
                            showAlert = true
                        }
                    }
        }
        .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
    }
    
    func formatDate(dateString: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"  
            inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            if let date = inputFormatter.date(from: dateString) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd-MM-yyyy"
                return outputFormatter.string(from: date)
            }
            return "Invalid date"
        }
}

