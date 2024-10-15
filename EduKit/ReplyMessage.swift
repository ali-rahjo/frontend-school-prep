
import SwiftUI

struct ReplyMessage: View {
    @State private var responseText: String = ""
    @State private var isPosting: Bool = false
    @State private var postSuccess: Bool = false
    @State private var postError: String?
    @State private var showSuccessAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var messageId: Int
    var messagecon:String
    
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
                        
                        Image("logo2")
                            .resizable()
                            .scaledToFill()
                          
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.bottom,20)
                        
                        
                        Text("\(messagecon)")
                            .font(.custom("Optima", size: 25))
                            .padding(.leading,10)
                            .foregroundColor(.white)
                        
                        TextEditor(text: $responseText)
                                    .frame(height: 150)
                                    .border(Color.gray, width: 1)
                                    .padding()
                                    .cornerRadius(8)
                                    .opacity(0.5)
                        
                        if isPosting {
                            ProgressView("Sending response...")
                        } else {
                            Button(action: {
                                postResponse()
                            }) {
                                Text("Send Reply")
                                    .padding()
                                    .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .fontWeight(.bold)
                            }
                            .disabled(responseText.isEmpty)
                        }

                        
                    }
                    .padding(.bottom,100)
                    .padding()
                    .alert(isPresented: $showSuccessAlert) {
                        Alert(title: Text("Success"), message: Text("Response sent successfully!"),  dismissButton: .default(Text("OK")) {
                          
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
            }
        }
    }
    
    // Function to post response to the API
    func postResponse() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/message/write/") else {
            print("Invalid URL")
            return
        }
        
        let postData: [String: Any] = [
            "id": messageId,
            "response": responseText
        ]
        
        // Convert dictionary to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: postData) else {
            print("Failed to convert data to JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        isPosting = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isPosting = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    postError = error.localizedDescription
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    postError = "Failed to send response. Please try again."
                }
                return
            }
            
            DispatchQueue.main.async {
                postSuccess = true
                responseText = "" 
                showSuccessAlert = true
                playSound(sound: "sound-rise", type: "mp3")
                feedback.notificationOccurred(.success)
            }
        }.resume()
    }
}
