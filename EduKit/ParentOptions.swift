import SwiftUI

struct ParentOptions: View {
    @State private var animateSignUp = false
    @State private var animateLogin = false

    var body: some View {
        ZStack {
            // Background image with dark overlay
            Image("slide8")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()

            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer(minLength: 30) // Reduced top spacing
                
                
                Image(systemName: "sparkles") // Replace with custom Genie icon if available
                                       .resizable()
                                       .frame(width: 40, height: 40)
                                       .foregroundColor(Color(red: 255/255, green: 232/255, blue: 177/255))
               
                
                Text("SchoolPrep Genie")
                                   .font(.custom("MarkerFelt-Wide", size: 48))  // Custom playful font
                                   .foregroundColor(Color(red: 255/255, green: 232/255, blue: 177/255))
                                   .shadow(color: .black, radius: 3, x: 1, y: 1)  // Text shadow for effect
                                   .padding(.top, 40)  // Top padding for positioning
                               
                               
                
                
                // Signup Button
                Button(action: {
                    // Handle signup action here
                }) {
                    NavigationLink(destination: Signup()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.blue)
                                .frame(width: 300, height: 60)

                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .offset(x: animateSignUp ? 0 : UIScreen.main.bounds.width) // Animate from right
                .animation(.easeOut(duration: 1.5), value: animateSignUp)
                
           //     Spacer(minLength: 5) // Reduced gap between buttons

                // Login Button
                Button(action: {
                    // Handle login action here
                }) {
                    NavigationLink(destination: LoginView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.blue)
                                .frame(width: 300, height: 60)

                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .offset(x: animateLogin ? 0 : UIScreen.main.bounds.width) // Animate from right
                .animation(.easeOut(duration: 1.8), value: animateLogin)

                Spacer(minLength: 400) // Reduced space at the bottom
            }
            .onAppear {
                animateSignUp = true
                animateLogin = true
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ParentOptions()
}

