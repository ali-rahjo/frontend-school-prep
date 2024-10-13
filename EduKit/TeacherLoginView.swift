import SwiftUI

struct TeacherLoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoggingIn: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToTeacher = false

    var body: some View {
        NavigationView {
        ZStack {
          
            Image("slide11")
                .resizable()
            .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .ignoresSafeArea()
            
            
            VStack {
                Spacer()

              
                Text("Welcome to")
                     .font(.custom("Noteworthy-Bold", size: 25))
                    .foregroundColor(Color.white)
                    .padding(.top, 40)

               
                Text("SchoolPrep")
                    .font(.custom("Noteworthy-Bold", size: 40))
                    .foregroundColor(Color.white)
                    .padding(.bottom, -10)
                
                Text("Genie")
                    .font(.custom("Bradley Hand", size: 26))
                    .foregroundColor(Color.white)
                    .padding(.leading, 100)
                
                Image("logo2")
                    .resizable()
                    .scaledToFill()
                  
                    .frame(width: 80, height: 75)
                    .clipShape(Circle())
                    .padding(.bottom,20)

               
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    TextField("Enter your username", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.white)
                        .padding()
                }
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)

               
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                    if showPassword {
                        TextField("Enter your password", text: $password)
                            .foregroundColor(.white)
                    } else {
                        SecureField("Enter your password", text: $password)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                .padding(.horizontal, 40)
                .padding(.bottom, 30)

                // Login Button
                Button(action: {
                    login(username: username, password: password) { result in
                            switch result {
                            case .success(let message):
                               
                                DispatchQueue.main.async {
                                    self.alertMessage = message
                                    resetFields()
                                    
                                    
                                    
                                    self.navigateToTeacher = true
                                }
                            case .failure(let error):
                               
                                DispatchQueue.main.async {
                                    self.alertMessage = error.localizedDescription
                                   
                                    
                                }
                            }
                        }
                }) {
                    HStack {
                        if isLoggingIn {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding(.trailing, 10)
                        }
                        Text("Login")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)
                }
                .disabled(isLoggingIn)
                
                // Forgot Password?
                Button(action: {
                    // Handle forgot password logic here
                }) {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                }

                Spacer()
                
                
                NavigationLink(destination: TeacherProfile(), isActive: $navigateToTeacher) {
                    EmptyView()
                }.navigationBarHidden(true)
                
            }.padding(.top,-70)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        }.navigationBarHidden(true)
    }
    
    
    private func resetFields() {
            username = ""
            password = ""
        }

   
       

    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        
        guard !username.isEmpty && !password.isEmpty else {
            alertMessage = "Please enter both username and password."
            showAlert = true
            return
        }
        
        
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/auth/login/") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["username": username, "password": password]
        
        print(username,password)

        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request body"])))
            return
        }

        request.httpBody = bodyData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                      //  print("Response status code: \(httpResponse.statusCode)")

                        if httpResponse.statusCode == 200 {
                         
                            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                            //    print("Success response: \(responseString)")  // Success response: {"key":"14186845819be86a4ae39430cfe063644e5d1278"}
                                completion(.success("Login successful"))
                            } else {
                                print("No response body received.")
                                completion(.success(""))
                            }
                        } else {
                           
                            if let data = data, let errorResponse = String(data: data, encoding: .utf8) {
                                print("Failure response: \(errorResponse)")
                                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse])))
                            } else {
                                print("No failure response body.")
                                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Unexpected error occurred."])))
                            }
                        }
                    }

           
            completion(.success("Login successful"))

        }.resume()
    }


}

struct StylishTeacherLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherLoginView()
    }
}

