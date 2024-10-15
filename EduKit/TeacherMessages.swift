

import SwiftUI

struct TeacherMessages: View {
    @StateObject private var viewModel = MessageRequestViewModel()
    
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
                        Text("Messages")
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
                                
                                
                                ForEach(viewModel.message) { request in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Message ID")
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
                                            Text("Class")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.class_name.capitalized)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("Message")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
                                            Text(request.text_msg.capitalized)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                      
                                        HStack {
                                            Text("Response")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 180, alignment: .leading)
    
                                            Text(request.response.isEmpty ? "Not yet replied" : request.response)
                                                    .foregroundColor(request.response.isEmpty ? Color.gray : Color.white)
                                                    .lineLimit(nil)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                       
                                        
                                        
                                        HStack() {
                                           
                                            Button(action: {
                                                    // Approve action
                                                                                      
                                            }) {
                                                Text(request.response.isEmpty ? "Reply" : "Replied")
                                                .padding()
                                                .background(request.response.isEmpty ? Color(red: 202/255, green: 32/255, blue: 104/255) : Color.gray.opacity(0.3))
                                                .foregroundColor(.white)
                                                .cornerRadius(8)
                                                .fontWeight(.bold)
                                                .frame(height: 25)
                                                .frame(width: 200, alignment: .leading)

                                              
                                            }.disabled(!request.response.isEmpty)
                                      
                                      
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
                viewModel.fetchMessageRequest()
            }
        }
    }
}

#Preview {
    TeacherMessages()
}


