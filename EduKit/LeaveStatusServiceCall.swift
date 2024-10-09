

import Foundation

struct Leave: Identifiable, Codable {
    let id: Int
    let parent_name: String
    let student_name: String
    let class_name: String
    let leave_type: String
    let status: String
    let leave_description: String
    let start_date: String
    let end_date: String
    let teacher_name: String
}

class LeaveStatusViewModel: ObservableObject {
    @Published var leaves: [Leave] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    // API call to fetch leave data
    func fetchLeaveStatus() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/apply/leave/") else {
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
                    let decodedLeaves = try JSONDecoder().decode([Leave].self, from: data)
                    self.leaves = decodedLeaves
                } catch {
                    self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

