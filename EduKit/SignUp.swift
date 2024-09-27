

import SwiftUI

struct Signup: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var address: String = ""
    @State private var phonenumber: String = ""
    @State private var selectedGender: String = "M"
    
    @State private var showStudentInfo = false
    @State private var studentInfo: StudentInfo?
    
    let genders = ["M", "F"]
    
   
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("slide7")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
                
                Color.black
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("Create an Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
    
                        .padding(.top, 80)
                   
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                    
                    TextField("First Name", text: $firstname)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Last Name", text: $lastname)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Address", text: $address)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Phone Number", text: $phonenumber)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .keyboardType(.phonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    HStack {
                        Picker("Gender", selection: $selectedGender) {
                            ForEach(genders, id: \.self) {
                                Text($0)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(8)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    NavigationLink(destination: StudentInfoView(studentInfo: studentInfo ?? StudentInfo(username: "",password:"", email: "", firstname: "", lastname: "", address: "", phonenumber: "", selectedGender: "")), isActive: $showStudentInfo) {
                        Button(action: {
                            // Prepare student info before navigating
                            studentInfo = StudentInfo(username: username, password:password,email: email, firstname: firstname, lastname: lastname, address: address, phonenumber: phonenumber, selectedGender: selectedGender)
                            showStudentInfo = true // Trigger navigation
                        }) {
                            Text("Submit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 220)
                                .background(Color(red: 33/255, green: 151/255, blue: 189/255))
                                .cornerRadius(8)
                        }
                    }
                    .isDetailLink(false) 
                    
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 120)
                .background(Color.white.opacity(0.2))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
    }
}

struct StudentInfo {
    var username: String
    var password:String
    var email: String
    var firstname: String
    var lastname: String
    var address: String
    var phonenumber: String
    var selectedGender: String
}

#Preview {
    Signup()
}
