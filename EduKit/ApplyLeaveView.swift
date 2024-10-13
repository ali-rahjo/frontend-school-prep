
import SwiftUI

struct ApplyLeaveView: View {
       @State private var parentId: Int?
       @State private var studentId: Int?
       @State private var leaveType: String = ""
       @State private var leaveDescription: String = ""
       @State private var startDate: String = ""
       @State private var endDate: String = ""
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
                
                Color.black
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                                Text("Apply Leave")
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

                                TextField("Leave Type", text: $leaveType)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: 280)

                                TextField("Leave Description", text: $leaveDescription)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: 280)

                                TextField("Start Date (YYYY-MM-DD)", text: $startDate)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: 280)

                                TextField("End Date (YYYY-MM-DD)", text: $endDate)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: 280)
                    
                           
                                Button(action: {
                                    playSound(sound: "sound-tap", type: "mp3")
                                    feedback.notificationOccurred(.success)
                                    guard let parentId = parentId, let studentId = studentId else {
                                                            errorMessage = "Parent ID and Student ID are required and must be numbers."
                                                            return
                                                        }
                                        let application = LeaveApplication(parent_id: parentId,
                                                                           student_id: studentId,
                                                                           leave_type: leaveType,
                                                                           leave_description: leaveDescription,
                                                                           start_date: startDate,
                                                                           end_date: endDate)
                                        
                                        isSubmitting = true
                                        errorMessage = nil
                                        applyLeave(application: application) { result in
                                            DispatchQueue.main.async {
                                                isSubmitting = false
                                                switch result {
                                                case .success:
                                                    alertMessage = "Leave applied successfully!"
                                                    showAlert = true
                                                case .failure(let error):
                                                    alertMessage = error.localizedDescription
                                                    showAlert = true
                                                }
                                            }
                                        }
                                    }) {
                                        Text(isSubmitting ? "Submitting..." : "SUBMIT")
                                            .padding()
                                            .frame(width: 200)
                                            .background(  LinearGradient(
                                                gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                                                            Color(red: 0/255, green: 0/255, blue: 150/255)]),
                                                startPoint: .top,
                                                endPoint: .bottom
                                     ))
                                       
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

                                  
                                
                }.padding(.top,50)
                .alert(isPresented: $showAlert) {
                                            Alert(
                                            title: Text("Success"),
                                            message: Text("Leave applied successfully!"),
                                            dismissButton: .default(Text("OK")) {
                                                resetFields()
                                            }
                                        )
                                    }
               
            }  .edgesIgnoringSafeArea(.all)
        }
    }
                                              
  private func resetFields() {
          parentId = nil
          studentId = nil
          leaveType = ""
          leaveDescription = ""
          startDate = ""
          endDate = ""
      }
}

#Preview {
    ApplyLeaveView()
}
