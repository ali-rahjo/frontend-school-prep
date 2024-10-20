import SwiftUI

struct TeacherWriteAnnouncement: View {
    @State private var announcement: String = ""
    @State private var isSubmitting: Bool = false
    @State private var submissionResponse: String = ""

    var body: some View {
        
        ZStack {
           
            Image("slide11")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .ignoresSafeArea()
            
        VStack(spacing: 20) {
            Text("Create Announcement")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("logo2")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(.bottom,20)
            


            TextEditor(text: $announcement)
                        .frame(height: 150)
                        .border(Color.gray, width: 1)
                        .padding()
                        .cornerRadius(8)
                        .opacity(0.5)

            Button(action: {
                submitAnnouncement()
            }) {
                Text("Submit")
                    .font(.headline)
                    .frame(maxWidth: 150)
                    .padding()
                    .background(Color(red: 202/255, green: 32/255, blue: 104/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .fontWeight(.bold)
            }
            .disabled(isSubmitting || announcement.isEmpty)

            if isSubmitting {
                ProgressView("Submitting...")
            }

            if !submissionResponse.isEmpty {
                Text(submissionResponse)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }

            Spacer()
        }.padding(.top,70)
        .padding()
        }
    }

    private func submitAnnouncement() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/announcement/create/") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["announcement": announcement]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        isSubmitting = true

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isSubmitting = false
                if let error = error {
                    submissionResponse = "Error: \(error.localizedDescription)"
                    return
                }
                
              
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    submissionResponse = "Announcement submitted successfully!"
                    announcement = "" // Clear the text field
                } else {
                    submissionResponse = "Failed to submit announcement."
                }
            }
        }

        task.resume()
    }
}

#Preview {
    TeacherWriteAnnouncement()
}

