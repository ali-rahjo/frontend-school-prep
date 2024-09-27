import SwiftUI



struct StudentInfoView: View {
    
    var studentInfo: StudentInfo
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var classid: String = ""
    @State private var age: String = ""
    @State private var selectedGender: String = "M"
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var students: [Student] = []
    
    let genders = ["M", "F"]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("slide9")
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
                    Text("Student Info")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top, 80)
                 
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
                    
                    TextField("Age", text: $age)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Class Id", text: $classid)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                   
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
                    
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .pickerStyle(SegmentedPickerStyle())
               
                    HStack(spacing: 20) {
                        Button(action: {
                           
                            if let ageInt = Int(age), let classIdInt = Int(classid) {
                            let newStudent = Student(firstName: firstname, lastName: lastname, age: ageInt, classId: classIdInt, gender: selectedGender, username: username, password: password)
                
                            students.append(newStudent)
                                resetForm()
                            }
                        }) {
                            Text("Add")
                                .padding()
                                .foregroundColor(.white)
                                .frame(minWidth: 150, maxWidth: 260)
                                .background(Color(red: 33/255, green: 151/255, blue: 189/255))
                                .cornerRadius(8)
                        }

                        Button(action: {
                            let parentInfo = ParentInfo(
                                    username: studentInfo.username,
                                    firstName: studentInfo.firstname,
                                    lastName: studentInfo.lastname,
                                    email: studentInfo.email,
                                    password: studentInfo.password,
                                    address: studentInfo.address,
                                    phoneNumber: studentInfo.phonenumber,
                                    gender: studentInfo.selectedGender,
                                    students: students
                                )
                                
                              
                                ParentRegistrationService.shared.registerParent(parentInfo: parentInfo) { result in
                                    switch result {
                                    case .success(let message):
                                        alertMessage = message
                                        showAlert = true
                                    case .failure(let error):
                                        alertMessage = error.localizedDescription
                                        showAlert = true
                                    }
                                }
                        }) {
                            Text("Sign Up")
                                .padding()
                                .foregroundColor(.white)
                                .frame(minWidth: 150, maxWidth: 260)
                                .background(Color(red: 33/255, green: 151/255, blue: 189/255))
                                .cornerRadius(8)
                        }
                        .alert(isPresented: $showAlert) {
                        Alert(title: Text("Registration Status"),message: Text(alertMessage),dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding()
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 120)
                .background(Color.white.opacity(0.2))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
        .navigationBarHidden(true)
    }
    
    // Function to reset the form fields
    func resetForm() {
        firstname = ""
        lastname = ""
        age = ""
        classid = ""
        username = ""
        password = ""
        selectedGender = "M"
    }
}

