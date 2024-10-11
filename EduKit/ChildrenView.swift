import SwiftUI

struct ChildrenView: View {
    
    @StateObject private var viewModel = ChildrenViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.top)
                
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
                                    .foregroundColor(.clear)
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
                                            .mask(Text("\(child.firstName.capitalized) \(child.lastName.capitalized)")
                                                    .font(.title))
                                    )
                            }
                            
                           
                            InfoRow(label: "Student ID", value: "\(child.id)")
                            InfoRow(label: "Username", value: "\(child.username)")
                            InfoRow(label: "Age", value: "\(child.age)")
                            InfoRow(label: "Gender", value: "\(child.gender)")
                            InfoRow(label: "Class ID", value: "\(child.classInfo.id)")
                            InfoRow(label: "Class", value: "\(child.classInfo.className)")
                            InfoRow(label: "Academic Year", value: "\(child.classInfo.academicYearStart) - \(child.classInfo.academicYearEnd)")
                            InfoRow(label: "Grade", value: "\(child.classInfo.grade)")
                            
                            if let teacher = child.teacher {
                                InfoRow(label: "Teacher", value: teacher.fullName.capitalized)
                            }
                            
                           
                            NavigationLink(destination: TimetableView(classID: child.classInfo.id, viewModel: TimetableViewModel())) {
                                Text("View Timetable")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)  // Smaller vertical padding for a smaller height
                                            .padding(.horizontal, 8)
                                    .background(
                                               LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                                              startPoint: .topLeading,
                                                              endPoint: .bottomTrailing)
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
            .onAppear {
                viewModel.fetchChildren()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct InfoRow: View {
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

#Preview {
    ChildrenView()
}


