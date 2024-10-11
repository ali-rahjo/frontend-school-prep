import SwiftUI

struct TimetableView: View {
    
    var classID: Int
    @ObservedObject var viewModel: TimetableViewModel
    
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Timetable...")
            } else if let timetable = viewModel.timetable{
                List {
                                  
                                  if let monday = timetable.timetableContent["Monday"] {
                                      Section(header: Text("Monday")) {
                                          ForEach(monday, id: \.period) { period in
                                              Text("Period \(period.period): \(period.subject)")
                                          }
                                      }
                                  }
                    

                                  if let tuesday = timetable.timetableContent["Tuesday"] {
                                      Section(header: Text("Tuesday")) {
                                          ForEach(tuesday, id: \.period) { period in
                                              Text("Period \(period.period): \(period.subject)")
                                          }
                                      }
                                  }
                    
                    
                                if let tuesday = timetable.timetableContent["Wednesday"] {
                                    Section(header: Text("Wednesday")) {
                                        ForEach(tuesday, id: \.period) { period in
                                            Text("Period \(period.period): \(period.subject)")
                                        }
                                    }
                                }
        
        
                                if let tuesday = timetable.timetableContent["Thursday"] {
                                    Section(header: Text("Thursday")) {
                                        ForEach(tuesday, id: \.period) { period in
                                            Text("Period \(period.period): \(period.subject)")
                                        }
                                    }
                                }
        
                    
                                if let tuesday = timetable.timetableContent["Friday"] {
                                    Section(header: Text("Friday")) {
                                        ForEach(tuesday, id: \.period) { period in
                                            Text("Period \(period.period): \(period.subject)")
                                        }
                                    }
                                }

                    
                                  
                                 
                              }
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                Text("No timetable available.")
            }
        }
        .onAppear {
            viewModel.fetchTimetable(classID: classID)  
        }
        .navigationTitle("Timetable")
    }
}

