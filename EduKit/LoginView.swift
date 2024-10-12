
import SwiftUI

struct LoginView: View {
    
    @State private var navigateToForgotPassword = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var navigateToParent = false
   
    @State private var alertMessage = ""
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("slide11")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
           
                
                VStack(spacing: 10) {
                   
                    Text("Welcome to")
                         .font(.custom("Noteworthy-Bold", size: 25))
                        .foregroundColor(Color.white)
                        .padding(.top, 70)

                   
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
                    
                    
                    TextField("Username", text: $username)
                       .padding()
                       .background(Color.white.opacity(0.8))
                       .cornerRadius(8)
                       .frame(width: 300)
                       .autocapitalization(.none)
                       .disableAutocorrection(true)
                       .padding(.bottom,50)

                   SecureField("Password", text: $password)
                       .padding()
                       .background(Color.white.opacity(0.8))
                       .cornerRadius(8)
                       .frame(width: 300)
                       .padding(.top,-40)
                       

                   Button(action: {
                    
                       
                       login(username: username, password: password) { result in
                               switch result {
                               case .success(let message):
                                  
                                   DispatchQueue.main.async {
                                       self.alertMessage = message
                                       resetFields()
                                       
                                       
                                       
                                       self.navigateToParent = true
                                   }
                               case .failure(let error):
                                  
                                   DispatchQueue.main.async {
                                       self.alertMessage = error.localizedDescription
                                      
                                       
                                   }
                               }
                           }
                   }) {
                       Text("Login")
                           .padding()
                           .foregroundColor(.white)
                           .frame(width: 250)
                           .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                           .cornerRadius(8)
                           .padding(.top,20)
                           .shadow(radius: 5)
                           .font(.headline)
                           .fontWeight(.bold)
                          
                   }
                  

                  
                   Button(action: {
                       navigateToForgotPassword = true
                   }) {
                       Text("Forgot Password?")
                           .foregroundColor(.white)
                           .underline()
                   }
                   .padding(.top)

               
                   NavigationLink(destination: ForgotPasswordView(), isActive: $navigateToForgotPassword) {
                       EmptyView()
                   }
                    
                    NavigationLink(destination: Parent(), isActive: $navigateToParent) {
                        EmptyView()
                    }.navigationBarHidden(true)
                }.padding(.bottom,150)
            }
        }.navigationBarHidden(true)
        
    }
    
    private func resetFields() {
            username = ""
            password = ""
        }
    
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
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

#Preview {
    LoginView()
}
           
