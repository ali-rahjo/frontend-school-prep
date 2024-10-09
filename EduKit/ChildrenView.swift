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
                            
                                HStack {
                                    Text("Student ID")
                                        .font(.headline)
                                        .frame(width: 150, alignment: .leading)
                                    Text("\(child.id)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }.padding(.top,5)
                            
                                HStack {
                                    Text("Username")
                                        .font(.headline)
                                        .frame(width: 150, alignment: .leading)
                                    Text("\(child.username)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                HStack {
                                    Text("Age")
                                        .font(.headline)
                                        .frame(width: 150, alignment: .leading)
                                    Text("\(child.age)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            
                                HStack {
                                    Text("Gender")
                                        .font(.headline)
                                        .frame(width: 150, alignment: .leading)
                                    Text("\(child.gender)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            
                               
                            
                                HStack {
                                    Text("Class ID")
                                        .font(.headline)
                                        .frame(width: 150, alignment: .leading)
                                    Text("\(child.classInfo.id)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                HStack {
                                    Text("Class")
                                        .frame(width: 150, alignment: .leading)
                                        .font(.headline)
                                    Text("\(child.classInfo.className)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                               

                                HStack {
                                    Text("Academic Year")
                                        .font(.headline)
                                        .frame(width: 150, alignment: .leading)
                                    Text("\(child.classInfo.academicYearStart) - \(child.classInfo.academicYearEnd)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                HStack {
                                    Text("Grade")
                                        .font(.headline)
                                        .frame(width: 150, alignment: .leading)
                                    Text("\(child.classInfo.grade)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            
                            
                                if let teacher = child.teacher {
                                 HStack {
                                        Text("Teacher")
                                         .font(.headline)
                                         .frame(width: 150, alignment: .leading)
                                     Text(teacher.fullName.capitalized)
                                         .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                }
                            
                        }  .padding(.vertical, 20)
                      
                            
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

#Preview {
    ChildrenView()
}
