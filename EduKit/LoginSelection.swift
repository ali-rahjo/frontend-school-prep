import SwiftUI

struct LoginSelection: View {
    @State private var animateParent = false
    @State private var animateStudent = false
    @State private var animateTeacher = false
    @State private var animateAdmin = false

    var body: some View {
        ZStack {
           
            Image("slide7")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()

            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)

           
            VStack {
                Spacer(minLength: 100)

               
                Text("Select Role")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 20)

             
                HStack(spacing: 20) {
                  
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
                            

                           
                            Image(systemName: "person.2.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                    }
                    .offset(y: animateParent ? 0 : UIScreen.main.bounds.height)

                   
                    Button(action: {
                        // Handle student login action here
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination: StudentLogin()) {
                                Text("Student")
                                    .font(.headline)
                                    .frame(width: 100, height: 100)
                                    .background(Color.green)
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
                            Text("Teacher")
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(5)

                           
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
                            Text("Admin")
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(5)

                           
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

