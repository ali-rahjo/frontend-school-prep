
import SwiftUI

struct TeacherSignup: View {
    
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var selectedGender: String = "M"
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State private var navigateToTeacherLogin = false
    

    
    let genders = ["M", "F"]
    
    
    var body: some View {
       
        ZStack{
            
            Image("slide11")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()

            

            VStack {
                
                
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
                
              
               
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(width: 280)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .frame(width: 280)
                    .padding(.top,5)
                
                TextField("First Name", text: $firstname)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(width: 280)
                    .padding(.top,5)
                
                TextField("Last Name", text: $lastname)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(width: 280)
                    .padding(.top,5)
                
                HStack {
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    .frame(width: 280)
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(8)
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top,5)
                }
                
                
                Button(action: {
                    
                    isLoading = true
                    
                    let teacherInfo = TeacherInfo(
                        
                        username: username,
                        firstName: firstname,
                        lastName: lastname,
                        password: password,
                        gender: selectedGender
                       
                    )
                    
                    TeacherRegistrationService.shared.registerTeacher(teacherInfo: teacherInfo) { result in
                        DispatchQueue.main.async {
                            isLoading = false
                        switch result {
                        case .success(let message):
                            alertMessage = message
                            showAlert = true
                            playSound(sound: "sound-rise", type: "mp3")
                            feedback.notificationOccurred(.success)
                        case .failure(let error):
                            alertMessage = error.localizedDescription
                            playSound(sound: "sound-rise", type: "mp3")
                            feedback.notificationOccurred(.success)
                            showAlert = true
                        }
                     }
                    }
                    
                  
                }) {
                    Text("SUBMIT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 220)
                        .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                        .cornerRadius(8)
                        .padding(.top,15)
                }

            }.padding(.bottom,100)
                .alert(isPresented: $showAlert) {
                                            Alert(
                                            title: Text("Success"),
                                            message: Text("Registered successfully!"),
                                            dismissButton: .default(Text("OK")) {
                                                resetFields()
                                                navigateToTeacherLogin = true
                                            }
                                        )
                                    }
            NavigationLink(
                destination: TeacherLoginView(),
                isActive: $navigateToTeacherLogin) {
                EmptyView()
                }.navigationBarHidden(true)
        }
        
        
    }
    
    private func resetFields() {
            username = ""
            password = ""
            firstname = ""
            lastname = ""
            
        }
}

#Preview {
    TeacherSignup()
}
