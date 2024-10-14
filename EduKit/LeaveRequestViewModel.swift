

import Foundation

struct LeaveRequest: Codable, Identifiable {
    let id: Int
    let parent: Int
    let parent_name: String
    let student: Int
    let student_name: String
    let class_name: String
    let leave_type: String
    let status: String
    let leave_description: String
    let start_date: String
    let end_date: String
    let teacher_name: String
    
}


class LeaveRequestViewModel: ObservableObject {
    @Published var leaveRequests: [LeaveRequest] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    
    func fetchLeaveRequests() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/leave/view/request/") else { return }
        
        
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
                    let decodedLeaves = try JSONDecoder().decode([LeaveRequest].self, from: data)
                    self.leaveRequests = decodedLeaves
                } catch {
                    self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
