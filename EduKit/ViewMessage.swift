import SwiftUI

struct ViewMessage: View {
    
    @StateObject private var viewModel = MessageStatusViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
               
                Image("slide12")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.2)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 20) {
                                
                                Text("Messages")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 10)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                ForEach(viewModel.message) { message in
                                    VStack(alignment: .leading, spacing: 10) {
                                       
                                        VStack(alignment: .leading, spacing: 8) {
                                        
                                           
                                            
                                            StylishRowItem(label: "Parent", value: message.parent_name.capitalized, icon: "person.circle.fill")
                                            StylishRowItem(label: "Student", value: message.student_name.capitalized, icon: "person.2.circle.fill")
                                            StylishRowItem(label: "Class", value: message.class_name.capitalized, icon: "building.2.crop.circle.fill")
                                            StylishRowItem(label: "Teacher", value: message.teacher_name.capitalized, icon: "person.crop.circle.fill.badge.checkmark")
                                            StylishRowItem(label: "Message", value: message.text_msg.capitalized, icon: "message.fill")
                                            StylishRowItem(label: "Reply", value: message.response.capitalized, icon: "bubble.left.and.bubble.right.fill")
                                        }
                                        .padding(15)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchMessageStatus()
                }
            }
        }
    }
}


struct StylishRowItem: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text("\(label)")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
                .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            Text(value.isEmpty ? "No reply yet" : value.capitalized)
                           .foregroundColor(value.isEmpty ? Color.gray : Color.white)
                           .fontWeight(.semibold)
                           .frame(maxWidth: .infinity, alignment: .leading)

        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ViewMessage()
}

