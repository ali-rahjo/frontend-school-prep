import SwiftUI

struct LoginSelection: View {
    @State private var animateParent = false
    @State private var animateStudent = false
    @State private var animateTeacher = false
    @State private var animateAdmin = false

    var body: some View {
        ZStack {
           
            Image("slide12")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()

           
            VStack {
                Spacer(minLength: 100)

               
                Text("Select Role")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 20)

             
                HStack(spacing: 20) {
                  
                    Button(action: {
                        playSound(sound: "sound-tap", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination: ParentOptions()) {
                                Text("Parent")
                                    .font(.headline)
                                    .frame(width: 100, height: 100)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                             }
                            
                           
                            Image(systemName: "person.2.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                    }
                    .offset(y: animateParent ? 0 : UIScreen.main.bounds.height)

                   
                    Button(action: {
                        playSound(sound: "sound-tap", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination: StudentLogin()) {
                                Text("Student")
                                    .font(.headline)
                                    .frame(width: 100, height: 100)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)

                            }
                            Image(systemName: "studentdesk")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                    }
                    .offset(y: animateStudent ? 0 : UIScreen.main.bounds.height)
                }
                .padding(.bottom, 20)

               
                HStack(spacing: 20) {
                  
                    Button(action: {
                        // Handle teacher login action here
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination:TeacherOptions()) {
                                Text("Teacher")
                                    .font(.headline)
                                    .frame(width: 100, height: 100)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)

                            }
                            Image(systemName: "person.crop.square.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                    }
                    .offset(y: animateTeacher ? 0 : UIScreen.main.bounds.height)

                   
                    Button(action: {
                        // Handle admin login action here
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination:Admin()) {
                            Text("Admin")
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                            }
                           
                            Image(systemName: "person.badge.plus.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                      
                        }
                    }
                    .offset(y: animateAdmin ? 0 : UIScreen.main.bounds.height)
                }

                Spacer(minLength: 400) 
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

