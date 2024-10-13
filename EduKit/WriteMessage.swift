

import SwiftUI

struct WriteMessage: View {
    
    @State private var parentId: Int?
    @State private var studentId: Int?
    @State private var message: String = ""
    @State private var response: String = ""
    @State private var isSubmitting: Bool = false
    @State private var alertMessage: String = ""
    @State private var errorMessage: String?
    @State private var showAlert: Bool = false
    
    
    var body: some View {
        
        
        NavigationView {
            
            
            ZStack {
                
                Image("slide12")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
                
                
                VStack(spacing: 20) {
                    
                    
                                Image("logo2")
                                    .resizable()
                                    .scaledToFill()
                                  
                                    .frame(width: 80, height: 75)
                                    .clipShape(Circle())
                                    .padding(.bottom,10)
                    
                                Text("Messages")
                                    .font(.title)
                                    .padding()
                                    .foregroundColor(Color.white)
                   
                       

                                TextField("Parent ID", value: $parentId, format: .number)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                                .keyboardType(.numberPad)
                                .disableAutocorrection(true)
                                .frame(width: 280)

                                TextField("Student ID", value: $studentId, format: .number)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                                .keyboardType(.numberPad)
                                .frame(width: 280)

                                TextField("Message", text: $message)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .multilineTextAlignment(.leading)
                                .frame(width: 280)

                              
                    
                    
                                Button(action: {
                                    isSubmitting = true
                                    guard let parentId = parentId, let studentId = studentId else {
                                                            errorMessage = "Parent ID and Student ID are required and must be numbers."
                                                            return
                                                        }
                                    
                                    let application = MessageApplication(parent_id: parentId,
                                                                       student_id: studentId,
                                                                       text_msg:message,
                                                                       response: ""
                                                                      )
                                    
                                    isSubmitting = true
                                    errorMessage = nil
                                    applyMessage(application: application) { result in
                                        DispatchQueue.main.async {
                                            isSubmitting = false
                                            switch result {
                                            case .success:
                                                alertMessage = "Message submitted successfully!"
                                                showAlert = true
                                                playSound(sound: "sound-rise", type: "mp3")
                                                feedback.notificationOccurred(.success)
                                            case .failure(let error):
                                                alertMessage = error.localizedDescription
                                                showAlert = true
                                            }
                                        }
                                    }
                                }){
                                Text(isSubmitting ? "Submitting..." : "SUBMIT")
                                    .padding()
                                    .frame(width: 200)
                                    .background(Color.black)
                               
                                    .font(.system(size: 16))
                                   
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .padding(.top,40)
                                }
                                .disabled(isSubmitting)
                    
                            if let errorMessage = errorMessage {
                                   Text(errorMessage)
                                       .padding()
                                       .foregroundColor(.red)
                               }
                }.padding(.bottom,100)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Message Status"), message: Text(alertMessage), 
                          dismissButton: .default(Text("OK")) {
                              resetFields()
                          })
                }
                
            }
        }
        
    }
    
    private func resetFields() {
            parentId = nil
            studentId = nil
            message = ""
            
           
        }
}

#Preview {
    WriteMessage()
}
