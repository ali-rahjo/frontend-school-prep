import Foundation
import Combine




class ChildrenViewModel: ObservableObject {
    @Published var children: [Child] = []
    @Published var isLoading: Bool = true
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    func fetchChildren() {
        self.isLoading = true
        ChildrenProfileService.shared.getChildrenProfile { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let children):
                    self.children = children
                    self.isLoading = false
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    self.isLoading = false
                }
            }
        }
    }
}

