import SwiftUI

struct SideMenuView: View {
    var body: some View {
        List {
            NavigationLink(destination: TimeTableView()) {
                Label("Time Table", systemImage: "calendar")
            }
            NavigationLink(destination: LunchMenu()) {
                Label("Luch Menu", systemImage: "calendar")
            }
            
            NavigationLink(destination: ApplyLeaveView()) {
                Label("Apply Leave", systemImage: "paperplane")
            }
            
            NavigationLink(destination: AttendanceView()) {
                Label("Attendance", systemImage: "person.crop.circle")
            }
            
            NavigationLink(destination: MessagesView()) {
                Label("Messages", systemImage: "message")
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
            
            Label("Logout", systemImage: "arrow.right.square")
           
        }
            }
}



struct TimeTableView: View {
    var body: some View {
        Text("Time Table View")
            .navigationTitle("Time Table")
    }
}

struct ApplyLeaveView: View {
    var body: some View {
        Text("Apply Leave View")
            .navigationTitle("Apply Leave")
    }
}

struct AttendanceView: View {
    var body: some View {
        Text("Attendance View")
            .navigationTitle("Attendance")
    }
}

struct MessagesView: View {
    var body: some View {
        Text("Messages View")
            .navigationTitle("Messages")
    }
}

struct AnnouncementsView: View {
    var body: some View {
        Text("Announcements View")
            .navigationTitle("Announcements")
    }
}

struct LunchMenu: View {
    var body: some View {
        Text("Lunch Menu")
            .navigationTitle("Lunch Menu")
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

