import SwiftUI

struct LoginSelection: View {
    @State private var animateParent = false
    @State private var animateStudent = false
    @State private var animateTeacher = false
    @State private var animateAdmin = false
    @State private var isAboutUsActive = false // State for About Us navigation

    var body: some View {
        NavigationView {
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
                        .font(.custom("Noteworthy", size: 35))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom, 20)

                    HStack(spacing: 20) {
                        // Parent Button
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
                        .offset(y: animateParent ? 0 : UIScreen.main.bounds.height)

                        // Student Button
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination: StudentLogin()) {
                                Text("Student")
                                    .font(.headline)
                                    .frame(width: 100, height: 100)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                            Image(systemName: "graduationcap.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -5, y: -5)
                        }
                        .offset(y: animateStudent ? 0 : UIScreen.main.bounds.height)
                    }
                    .padding(.bottom, 20)

                    HStack(spacing: 20) {
                        // Teacher Button
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination: TeacherOptions()) {
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
                        .offset(y: animateTeacher ? 0 : UIScreen.main.bounds.height)

                        // Admin Button
                        ZStack(alignment: .bottomTrailing) {
                            NavigationLink(destination: Admin()) {
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
                        .offset(y: animateAdmin ? 0 : UIScreen.main.bounds.height)
                    }


                }
                .padding(.bottom,350)
                .onAppear {
                    withAnimation(.easeOut(duration: 1.5)) { animateParent = true }
                    withAnimation(.easeOut(duration: 1.8)) { animateStudent = true }
                    withAnimation(.easeOut(duration: 2.1)) { animateTeacher = true }
                    withAnimation(.easeOut(duration: 2.4)) { animateAdmin = true }
                }
            }
        }
    }
}
