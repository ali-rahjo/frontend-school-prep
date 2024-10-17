import SwiftUI

struct AttendanceView: View {
    
    @StateObject private var viewModel = ChildrenViewModel()

    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .scaleEffect(1.5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .navigationBarTitle("Children", displayMode: .inline)
                } else {
                    List(viewModel.children) { child in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(child.firstName.capitalized) \(child.lastName.capitalized)")
                                    .font(.title)
                                    .foregroundColor(.clear) // Consider removing this
                                    .overlay(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                                                        Color(red: 0/255, green: 0/255, blue: 150/255)]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                        .mask(Text("\(child.firstName.capitalized) \(child.lastName.capitalized)")
                                                .font(.title))
                                    )
                            }
                            
                            InfoRows(label: "Student ID", value: "\(child.id)")
                            InfoRows(label: "Class", value: "\(child.classInfo.className)")
                            
                            if let teacher = child.teacher {
                                InfoRow(label: "Teacher", value: teacher.fullName.capitalized)
                            }
                            
                            NavigationLink(destination: AttendanceViewList(studentID: child.id)) {
                                Text("Attendance")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .frame(maxHeight: 38)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                                                        Color(red: 0/255, green: 0/255, blue: 150/255)]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .cornerRadius(8)
                            }
                            .padding(.top, 10)
                        }
                        .padding(.vertical, 20)
                    }
                    .cornerRadius(8)
                    .shadow(radius: 5)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                                Color(red: 0/255, green: 0/255, blue: 150/255)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .onAppear {
                viewModel.fetchChildren()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct InfoRows: View { // Renamed from InfoRoww to InfoRow
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .frame(width: 150, alignment: .leading)
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 5)
    }
}



