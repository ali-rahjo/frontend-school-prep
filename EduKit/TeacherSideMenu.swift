import SwiftUI

struct TeacherSideMenu: View {
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showConfirmationDialog = false
    @State private var isLoggingOut = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isNavigatingToLogoutView = false
    var classId: Int
    var teacherId: Int
    
    
    var body: some View {
      
        List {
            
        
            NavigationLink(destination: TeacherLeaves()) {
                Label("Leaves", systemImage: "doc.text")
            }
            
         
            NavigationLink(destination: TeacherAttendance()) {
                Label("Attendance", systemImage: "person.crop.circle")
            }
            
            NavigationLink(destination: TeacherAttendanceList()) {
                Label("Attendance List", systemImage: "person.fill.checkmark")
            }
            
            NavigationLink(destination: TeacherMessages()) {
                Label("Messages", systemImage: "message")
            }
            NavigationLink(destination: CreateTimeTable(classId: classId,teacherId:teacherId)) {
                Label("Add Time Table", systemImage: "square.and.pencil")
            }
            
            NavigationLink(destination: TeacherTimeTable(classId: classId)) {
                Label("Time Table", systemImage: "envelope.open.fill")
            }
            
            NavigationLink(destination: CreateLunchMenu()) {
                Label("Add Lunch Menu", systemImage: "tray.fill")
            }
            
            NavigationLink(destination: LunchMenuView()) {
                Label("Lunch Menu", systemImage: "fork.knife.circle.fill")
            }
            
            NavigationLink(destination: TeacherAnnouncement()) {
                Label("Announcements", systemImage: "megaphone")
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




