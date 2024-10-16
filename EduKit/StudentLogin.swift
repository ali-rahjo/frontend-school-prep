import SwiftUI

struct StudentLogin: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToStudent = false

    var body: some View {
  
            ZStack {

                Image("slide8")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
                
                VStack {
                              
                               Text("Welcome to")
                                    .font(.custom("Noteworthy-Bold", size: 25))
                                   .foregroundColor(Color.white)
                                   .padding(.top, 50)

                              
                               Text("SchoolPrep")
                                   .font(.custom("Noteworthy-Bold", size: 40))
                                   .foregroundColor(Color.white)
                                   .padding(.bottom, 10)
                    
                                Text("Genie")
                                    .font(.custom("Bradley Hand", size: 26))
                                    .foregroundColor(Color.white)
                                    .padding(.leading, 100)
                                    .padding(.top,-25)
                               
                             
                               Image("logo")
                                   .resizable()
                                   .scaledToFill()
                                 
                                   .frame(width: 80, height: 75)
                                   .clipShape(Circle())
                                   .padding(.bottom,30)
                                  
                                   
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 320)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 320)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
                        .padding(.top,20)

                  
                    Button(action: {
                       
                        login(username: username, password: password) { result in
                                switch result {
                                case .success(let message):
                                   
                                    DispatchQueue.main.async {
                                        self.alertMessage = message
                                        resetFields()
                                        
                                        self.navigateToStudent = true
                                    }
                                case .failure(let error):
                                   
                                    DispatchQueue.main.async {
                                        self.alertMessage = error.localizedDescription
                                       
                                        
                                    }
                                }
                            }
                    }) {
                        Text("Login")
                            .frame(maxWidth: 180)
                            .padding()
                            .background(Color.blue)
                            .font(.system(size: 20)) 
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top,30)
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 200)
                    
                    NavigationLink(destination: StudentProfile(), isActive: $navigateToStudent) {
                                            EmptyView() 
                                        }
                }
                .padding(.bottom, 20)
             
            }
           
                
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
                        print("Response status code: \(httpResponse.statusCode)")

                        if httpResponse.statusCode == 200 {
                         
                            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                                print("Success response: \(responseString)")  // Success response: {"key":"14186845819be86a4ae39430cfe063644e5d1278"}
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

struct StudentLogin_Previews: PreviewProvider {
    static var previews: some View {
        StudentLogin()
    }
}

