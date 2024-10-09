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
    @State private var navigateToLogin = false
    @State private var isLoading = false
   
    
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
                        .frame(width: 300)
                    
                    TextField("Last Name", text: $lastname)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(width: 300)
                    
                    TextField("Age", text: $age)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(width: 300)
                    
                    TextField("Class Id", text: $classid)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(width: 300)
                   
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(width: 300)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 300)
                    
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300)
                    
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
                                .frame(width: 140)
                                .background(Color(red: 33/255, green: 151/255, blue: 189/255))
                                .cornerRadius(8)
                                .font(.headline)
                        }

                        Button(action: {
                           
                            isLoading = true
                            
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
                                DispatchQueue.main.async {
                                    isLoading = false
                                switch result {
                                case .success(let message):
                                    alertMessage = message
                                    showAlert = true
                                case .failure(let error):
                                    alertMessage = error.localizedDescription
                                    showAlert = true
                                }
                             }
                            }
                        }) {
                            Text("Sign Up")
                                .padding()
                                .foregroundColor(.white)
                                .frame(width: 130)
                                .background(Color(red: 33/255, green: 151/255, blue: 189/255))
                                .cornerRadius(8)
                                .font(.headline)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("SchoolPrep Genie"),
                                  message: Text(alertMessage),
                                  dismissButton: .default(Text("OK"), action: {
                                      if alertMessage.contains("Invitation") {
                                          navigateToLogin = true
                                      }
                                  }))
                        }
                        
                        
                        NavigationLink(
                            destination: LoginView(),
                            isActive: $navigateToLogin) {
                            EmptyView()
                            }.navigationBarHidden(true)
                    }
                    .padding(.leading,20)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 120)
                .background(Color.white.opacity(0.2))
                .cornerRadius(15)
                .shadow(radius: 10)
                
                if isLoading {
                            Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                                    
                            ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.white)
                            .scaleEffect(1.5)
                    }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarHidden(true)
    }
    
   
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

