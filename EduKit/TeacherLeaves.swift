import SwiftUI

struct TeacherLeaves: View {
    @StateObject private var viewModel = LeaveRequestViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
               
                Image("slide11")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
                
               
                VStack {
                    
                    HStack {
                        Text("Leaves")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10) {
                                
                                
                                ForEach(viewModel.leaveRequests) { request in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Leave ID")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                          
                                            Text("\(request.id)")
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                        }
                                        HStack {
                                            Text("Parent")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.parent_name.capitalized)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                        }
                                        HStack {
                                            Text("Student")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.student_name.capitalized)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("Class:")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.class_name.capitalized)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("Leave Type:")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.leave_type.capitalized)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("Status:")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.status.capitalized)
                                                .foregroundColor(request.status == "Approved" ? .green : .red)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("Description:")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.leave_description)
                                                .foregroundColor(.white)
                                                .lineLimit(nil)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("Start Date:")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.start_date)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("End Date:")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.end_date)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        Spacer()
                                        
                                        HStack() {
                                           
                                            Button(action: {
                                                    // Approve action
                                                                                      
                                            }) {
                                            Text("Approve")
                                                .padding()
                                                .background(Color.green)
                                                .foregroundColor(.white)
                                                .cornerRadius(8)
                                                .fontWeight(.bold)
                                                .frame(height: 25)
                                                .frame(width: 180, alignment: .leading)

                                              
                                            }
                                           
                                           
                                            
                                            Button(action: {
                                                    // Approve action
                                                                                      
                                            }) {
                                            Text("Reject")
                                                .padding()
                                                .background(Color.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(8)
                                                .fontWeight(.bold)
                                                .frame(height: 25)
                                                .frame(maxWidth: .infinity, alignment: .leading)

                                              
                                            }
                                    
                                      
                                      
                                   } .padding(.top, 30)
                                            .padding(.bottom,10)
                                    
                                        
                                        
                                        
                                    }.frame(width: 320)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10)
                                }
                                .padding(.horizontal)
                            }
                        }
                    
                }
                }
               
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                viewModel.fetchLeaveRequests()
            }
        }
    }
}

#Preview {
    TeacherLeaves()
}

