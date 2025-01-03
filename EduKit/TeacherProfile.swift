import SwiftUI

struct TeacherProfile: View {
    
    @State private var isMenuOpen = false
    @State private var isLoading = true
    @State private var teacherProfile: [String: Any] = [:]
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @State private var uploadStatus: String = ""

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
                            .frame(height: 285)

                        VStack(spacing: 16) {
                    
                            
                            if let imageUrlString = teacherProfile["profile_image_url"] as? String,
                                                          let imageUrl = URL(string: imageUrlString) {
                                                           AsyncImage(url: imageUrl) { phase in
                                                               if let image = phase.image {
                                                                   image
                                                                       .resizable()
                                                                       .frame(width: 120, height: 120)
                                                                       .clipShape(Circle())
                                                                       .padding(.bottom,-20)
                                                               } else if phase.error != nil {
                                                                   Image(systemName: "person.circle.fill")
                                                                       .resizable()
                                                                       .frame(width: 100, height: 100)
                                                                       .foregroundColor(.white)
                                                                   

                                                                  
                                                               } else {
                                                                   ProgressView()
                                                                       .frame(width: 100, height: 100)
                                                               }
                                                           }
                                                       } else {
                                                           Image(systemName: "person.circle.fill")
                                                               .resizable()
                                                               .frame(width: 120, height: 120)
                                                               .foregroundColor(.white)
                                                           
                                                          
                                                       }
                            Button(action: {
                                showImagePicker.toggle()
                            }) {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .padding(.leading,60)
                                    .padding(.top,-10)
                                    
                            }
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(selectedImage: $selectedImage)
                            }
                            .onChange(of: selectedImage) { newImage in
                                if let newImage = newImage {
                                    uploadImage(selectedImage: newImage)
                                }
                               
                            }
                           
                            
                            if let user = teacherProfile["user"] as? [String: Any],
                                    let firstName = user["first_name"] as? String,
                                    let lastName = user["last_name"] as? String {
                                    Text("\(firstName.capitalized) \(lastName.capitalized)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.bottom,80)
                            } else {
                                    Text("Anna Avetisyan")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, -10)
                    } .padding(.bottom, -30)

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
                                Image(systemName: "number")
                                    .foregroundColor(.pink)
                                    .opacity(0.8)
                                if let classId = teacherProfile["class_id"] as? Int {
                                    Text("Class ID \(classId)")
                                } else {
                                    Text("Class ID not available")
                                }
                                Spacer()
                            }
                        
                        HStack {
                               Image(systemName: "graduationcap")
                                   .foregroundColor(.pink)
                                   .opacity(0.8)
                               Text("\(teacherProfile["class_name"] as? String ?? "Unknown")")
                               Spacer()
                           }
                        
                       
                        
                        HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.pink)
                                    .opacity(0.8)
                                Text("\(teacherProfile["academic_year_start"] as? Int ?? 0)-\(teacherProfile["academic_year_end"] as? Int ?? 0)")
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
                                .frame(maxWidth: 200)
                               
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
                                .padding(.leading,50)
                        }
                        .padding(.top)
                       
                    }
                    .padding(.top, -40)
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

              
                TeacherSideMenu(classId: teacherProfile["class_id"] as? Int ?? 0,teacherId:teacherProfile["id"] as? Int ?? 0)
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
    
    func uploadImage(selectedImage: UIImage) {
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
                self.uploadStatus = "Failed to convert image to data."
                return
            }

           
            let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/profile/image/")!
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"

           
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            
            var body = Data()
            let filename = "profile_image.jpg"
            let mimetype = "image/jpeg"

            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"profile_image\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)

           
            request.httpBody = body

          
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.uploadStatus = "Upload failed: \(error.localizedDescription)"
                    }
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.uploadStatus = "Image uploaded successfully!"
                        TeacherProfileService.shared.getTeacherProfile { result in
                                            switch result {
                                            case .success(let profile):
                                                DispatchQueue.main.async {
                                                    self.teacherProfile = profile
                                                }
                                            case .failure(let error):
                                                print("Error fetching profile: \(error.localizedDescription)")
                                            }
                                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.uploadStatus = "Failed to upload image."
                    }
                }
            }.resume()
        }
}

