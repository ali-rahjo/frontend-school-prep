import SwiftUI

struct LoginSelection: View {
    @State private var animateParent = false
    @State private var animateStudent = false
    @State private var animateTeacher = false
    @State private var animateAdmin = false

    var body: some View {
        ZStack {
            // Background image with dark overlay
            Image("slide7")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()

            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            // VStack for the text and buttons
            VStack {
                Spacer(minLength: 100) // Top space before the text

                // Title text
                Text("Select Role")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 20) // Reduced space below the text

                // First row: Parent and Student
                HStack(spacing: 20) { // Reduced spacing between buttons
                    // Parent Button
                    Button(action: {
                        // Handle parent login action here
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination: ParentOptions()) {
                                Text("Parent")
                                    .font(.headline)
                                    .frame(width: 100, height: 100)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                             }
                            

                            // Small icon on bottom-right corner
                            Image(systemName: "person.2.fill") // Using system icon for parent
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5) // Positioning the icon
                        }
                    }
                    .offset(y: animateParent ? 0 : UIScreen.main.bounds.height)

                    // Student Button
                    Button(action: {
                        // Handle student login action here
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            Text("Student")
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(5)

                            // Small icon on bottom-right corner
                            Image(systemName: "studentdesk") // Using custom icon for student
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                    }
                    .offset(y: animateStudent ? 0 : UIScreen.main.bounds.height)
                }
                .padding(.bottom, 20) // Reduced space between rows

                // Second row: Teacher and Admin
                HStack(spacing: 20) { // Reduced spacing between buttons
                    // Teacher Button
                    Button(action: {
                        // Handle teacher login action here
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            Text("Teacher")
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(5)

                            // Small icon on bottom-right corner
                            Image(systemName: "person.crop.square.fill") // Using system icon for teacher
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                    }
                    .offset(y: animateTeacher ? 0 : UIScreen.main.bounds.height)

                    // Admin Button
                    Button(action: {
                        // Handle admin login action here
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            Text("Admin")
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(5)

                            // Small icon on bottom-right corner
                            Image(systemName: "person.badge.plus.fill") // Using system icon for admin
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                    }
                    .offset(y: animateAdmin ? 0 : UIScreen.main.bounds.height)
                }

                Spacer(minLength: 400) // Reduced space at the bottom
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) {
                    animateParent = true
                }
                withAnimation(.easeOut(duration: 1.8)) {
                    animateStudent = true
                }
                withAnimation(.easeOut(duration: 2.1)) {
                    animateTeacher = true
                }
                withAnimation(.easeOut(duration: 2.4)) {
                    animateAdmin = true
                }
            }
        }
       
    }
}

#Preview {
    LoginSelection()
}

