

import SwiftUI
import Combine



class TimetableViewModel: ObservableObject {
    
    @Published var timetable: TimetableResponse? 

    @Published var isLoading: Bool = true
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchTimetable(classID: Int) {
        isLoading = true
        TimetableService.shared.fetchTimetable(classID: classID) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let timetable):
                    if let firstTimetable = timetable.first {
                            self.timetable = firstTimetable
                    } else {
                            self.errorMessage = "No timetable available."
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}



