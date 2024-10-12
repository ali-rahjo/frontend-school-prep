

import SwiftUI

struct TeacherOptions: View {
    @State private var animateSignUp = false
    @State private var animateLogin = false
    var body: some View {
        ZStack{
            
            Image("slide12")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()

            

            VStack {
                Spacer(minLength: 30)
                
                Text("Welcome to")
                     .font(.custom("Noteworthy-Bold", size: 25))
                    .foregroundColor(Color.white)
                    .padding(.top, 40)

               
                Text("SchoolPrep")
                    .font(.custom("Noteworthy-Bold", size: 40))
                    .foregroundColor(Color.white)
                    .padding(.bottom, -10)
                
                Text("Genie")
                    .font(.custom("Bradley Hand", size: 26))
                    .foregroundColor(Color.white)
                    .padding(.leading, 100)
                
                Image("logo2")
                    .resizable()
                    .scaledToFill()
                  
                    .frame(width: 80, height: 75)
                    .clipShape(Circle())
                    .padding(.bottom,20)
               

                
                
                
                Button(action: {
                    // Handle signup action here
                }) {
                    NavigationLink(destination: Signup()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.black)
                                .frame(width: 300, height: 60)

                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                               
                        }
                    }
                }
                .offset(x: animateSignUp ? 0 : UIScreen.main.bounds.width)
                .animation(.easeOut(duration: 1.5), value: animateSignUp)
                
          

              
                Button(action: {
                    // Handle login action here
                }) {
                    NavigationLink(destination: TeacherLoginView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.black)
                                .frame(width: 300, height: 60)

                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .offset(x: animateLogin ? 0 : UIScreen.main.bounds.width)
                .animation(.easeOut(duration: 1.8), value: animateLogin)

                Spacer(minLength: 400)
            }
            .padding(.top,200)
            .onAppear {
                animateSignUp = true
                animateLogin = true
            }
        }
    }
    
}

#Preview {
    TeacherOptions()
}
