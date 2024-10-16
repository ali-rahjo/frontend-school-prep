import SwiftUI

struct SideMenuView: View {
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showConfirmationDialog = false
    @State private var isLoggingOut = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isNavigatingToLogoutView = false
    
    var body: some View {
      
        List {
            
         
           
            NavigationLink(destination: LunchMenuView()) {
                Label("Luch Menu", systemImage: "fork.knife")
            }
            
            NavigationLink(destination: ApplyLeaveView()) {
                Label("Apply Leave", systemImage: "paperplane")
            }
            
            NavigationLink(destination: LeaveStatusView()) {
                Label("Leave Status", systemImage: "doc.text")
            }
            
            NavigationLink(destination: AttendanceView()) {
                Label("Attendance", systemImage: "person.crop.circle")
            }
            
            NavigationLink(destination: WriteMessage()) {
                Label("Messages", systemImage: "message")
            }
            
            NavigationLink(destination: ViewMessage()) {
                Label("Message Status", systemImage: "envelope.open.fill")
            }
            
            NavigationLink(destination: AnnouncementsView()) {
                Label("Announcements", systemImage: "megaphone")
            }
            
            NavigationLink(destination: ChildrenView()) {
                Label("Children Info", systemImage: "person.2")
            }
           
            NavigationLink(destination: Holiday()) {
                Label("Holiday Calendar", systemImage: "calendar")
            }
            
            Button(action: {
                showConfirmationDialog = true
            }) {
                Label("Logout", systemImage: "arrow.right.square")
                    .foregroundColor(.red)
            }
           
        }.confirmationDialog("Are you sure you want to log out?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            Button("Log out", role: .destructive) {
                isNavigatingToLogoutView = true
            }
                Button("Cancel", role: .cancel) { }
        } .background(
            NavigationLink(destination: Logout(), isActive: $isNavigatingToLogoutView) {
                EmptyView()
            }
            .hidden()
        )
        

      
    }
    
    
    func logout() {
          // isLoggingOut = true
           guard let url = URL(string: "http://192.168.0.219:8000/api/v1/auth/logout/") else {
               DispatchQueue.main.async {
               alertMessage = "Invalid URL"
               showAlert = true
              // isLoggingOut = false
               }
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"  
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")

           // If authentication token is needed, add it here, for example:
           // request.addValue("Bearer <token>", forHTTPHeaderField: "Authorization")

           URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                 //  isLoggingOut = false
                   if let error = error {
                       alertMessage = "Error: \(error.localizedDescription)"
                       showAlert = true
                       return
                   }

                   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                       alertMessage = "Failed to log out. Please try again."
                       showAlert = true
                       return
                   }

                  
                   alertMessage = "Successfully logged out."
                   showAlert = true
                   playSound(sound: "sound-rise", type: "mp3")
                   feedback.notificationOccurred(.success)
               }
           }.resume()
       }
}



struct TimeTableView: View {
    var body: some View {
        Text("Time Table View")
            .navigationTitle("Time Table")
    }
}



struct AnnouncementsView: View {
    var body: some View {
        Text("Announcements View")
            .navigationTitle("Announcements")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
