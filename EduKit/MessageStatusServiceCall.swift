
import Foundation

struct MessageStatus: Identifiable, Codable {
    let id: Int
    let parent_name: String
    let student_name: String
    let class_name: String
    let teacher_name: String
    let text_msg: String
    let response: String
}

class MessageStatusViewModel: ObservableObject {
    @Published var message: [MessageStatus] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchMessageStatus() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/write/message/") else {
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
                
                do {
                    let decodedLeaves = try JSONDecoder().decode([MessageStatus].self, from: data)
                    self.message = decodedLeaves
                } catch {
                    self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    }
