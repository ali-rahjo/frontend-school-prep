import Combine
import SwiftUI

class StudentProfileViewModel: ObservableObject {
    
    @Published var student: Students?
    @Published var isLoading = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchStudentProfile() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/student/profile/") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Students.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isLoading = false
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { student in
                self.student = student
                self.isLoading = false
            })
            .store(in: &self.cancellables)
    }
}

