

import SwiftUI

struct LeaveStatusView: View {
    
    @StateObject private var viewModel = LeaveStatusViewModel()
    
    
    var body: some View {
        
            
            NavigationView {
                
                
                ZStack {
                    Image("slide12")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                        .ignoresSafeArea()
                    
                  
                
                
                       VStack {
                           if viewModel.isLoading {
                               ProgressView("Loading...") 
                           } else if let errorMessage = viewModel.errorMessage {
                               Text(errorMessage)
                                   .foregroundColor(.red)
                           } else {
                               ScrollView {
                                   LazyVStack(alignment: .center, spacing: 15) {
                                       
                                       Text("Leave Info")
                                               .font(.title)
                                               .fontWeight(.bold)
                                               .padding(.bottom, 5)
                                               .foregroundColor(Color.white)
                                       
                                       ForEach(viewModel.leaves) { leave in
                                           VStack(alignment: .leading) {
                                               
                                              
                                               
                                               HStack {
                                                       Text("Parent")
                                                           .font(.headline)
                                                          
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.parent_name.capitalized)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                      
                                                   }
                                                   
                                                   HStack {
                                                       Text("Student")
                                                           .font(.headline)
                                                          
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.student_name.capitalized)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                           
                                                   }
                                                   
                                                   HStack {
                                                       Text("Class")
                                                           .font(.headline)
                                                           
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.class_name.capitalized)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                   }
                                                   HStack {
                                                       Text("Date Sent")
                                                           .font(.headline)
                                                           
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.date)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                                                   }
                                                   
                                                   HStack {
                                                       Text("Leave Type")
                                                           
                                                           .font(.headline)
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.leave_type.capitalized)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                           
                                                   }
                                                   
                                                   HStack {
                                                       Text("Status")
                                                           .foregroundColor(Color(red: 202/255, green: 32/255, blue: 104/255))
                                                           .font(.headline)
                                                           .frame(width: 180, alignment: .leading)
                                                       Text(leave.status.capitalized)
                                                           .foregroundColor(leave.status == "Approved" ? .green : .red)
                                                           .frame(maxWidth: .infinity, alignment: .leading)
                                                           
                                                   }
                                                   
                                               
                                                   
                                                   HStack {
                                                       Text("Start Date")
                                                           
                                                           .font(.headline)
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.start_date.capitalized)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                           
                                                   }
                                                   
                                                   HStack {
                                                       Text("End Date")
                                                           
                                                           .font(.headline)
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.end_date.capitalized)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                           
                                                   }
                                                   
                                                   HStack {
                                                       Text("Teacher")
                                                          
                                                           .font(.headline)
                                                           .frame(width: 180, alignment: .leading)
                                                                   Text(leave.teacher_name.capitalized)
                                                                       .frame(maxWidth: .infinity, alignment: .leading)
                                                           
                                                   }
                                               
                                                   VStack(alignment: .leading) {
                                                          Text("Reason:")
                                                          
                                                           .font(.headline)
                                                          Text(leave.leave_description)
                                                              .multilineTextAlignment(.leading)
                                                              .frame(maxWidth: .infinity, alignment: .leading)
                                                              .lineLimit(nil)
                                                      }
                                                      .padding(.top, 5)
                                           }
                                           .padding()
                                           .background(Color(UIColor.secondarySystemBackground))
                                           .cornerRadius(8)
                                       }
                                   }
                                   .padding()
                               }
                           }
                       }
                       .onAppear {
                           viewModel.fetchLeaveStatus()
                       }
                   }
               }
        
        
        
        
    }
}

#Preview {
    LeaveStatusView()
}
