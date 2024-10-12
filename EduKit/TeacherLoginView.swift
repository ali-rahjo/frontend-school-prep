import SwiftUI

struct TeacherLoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoggingIn: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        ZStack {
          
            Image("slide12")
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
                .background(Color.white.opacity(0.15))
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
                .background(Color.white.opacity(0.15))
                .cornerRadius(10)
                .padding(.horizontal, 40)
                .padding(.bottom, 30)

                // Login Button
                Button(action: {
                    login()
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
                    .background(Color.black)
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
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func login() {
        guard !username.isEmpty && !password.isEmpty else {
            alertMessage = "Please enter both username and password."
            showAlert = true
            return
        }

        isLoggingIn = true
        let loginData = ["username": username, "password": password]

        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/auth/login/") else {
            alertMessage = "Invalid URL."
            showAlert = true
            isLoggingIn = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginData, options: .fragmentsAllowed)
        } catch {
            alertMessage = "Failed to encode login data."
            showAlert = true
            isLoggingIn = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoggingIn = false
                if let error = error {
                    alertMessage = "Login failed: \(error.localizedDescription)"
                    showAlert = true
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    alertMessage = "Invalid credentials or server error."
                    showAlert = true
                    return
                }

                // Handle successful login (e.g., navigate to dashboard)
                alertMessage = "Login successful!"
                showAlert = true
            }
        }.resume()
    }
}

struct StylishTeacherLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherLoginView()
    }
}

