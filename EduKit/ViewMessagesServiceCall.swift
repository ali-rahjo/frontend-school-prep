

import Foundation

struct MessageRequest: Codable, Identifiable {
      let id: Int
      let parent: Int
      let parent_name: String
      let student: Int
      let student_name: String
      let teacher_name: String
      let class_name: String
      let text_msg: String
      let response: String
      let date: String
    
}

class MessageRequestViewModel: ObservableObject {
    @Published var message: [MessageRequest] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchMessageRequest() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/message/view/") else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                                 print("Response body: \(responseString)")
                             }
                
                do {
                    let decodedLeaves = try JSONDecoder().decode([MessageRequest].self, from: data)
                    self.message = decodedLeaves
                } catch {
                    self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    }

