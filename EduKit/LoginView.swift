
import SwiftUI

struct LoginView: View {
    
    @State private var navigateToForgotPassword = false
    @State private var username: String = ""
@State private var password: String = ""
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("slide8")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
                
              
                
                VStack(spacing: 20) {
                   
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top, 60)
                    
                    
                    TextField("Username", text: $username)
                       .padding()
                       .background(Color.white.opacity(0.8))
                       .cornerRadius(8)
                       .frame(width: 300)
                       .autocapitalization(.none)
                       .disableAutocorrection(true)

                   SecureField("Password", text: $password)
                       .padding()
                       .background(Color.white.opacity(0.8))
                       .cornerRadius(8)
                       .frame(width: 300)

                   Button(action: {
                       Parent()
                   }) {
                       Text("Login")
                           .padding()
                           .foregroundColor(.white)
                           .frame(width: 150)
                           .background(Color.blue)
                           .cornerRadius(8)
                   }
                  

                  
                   Button(action: {
                       navigateToForgotPassword = true
                   }) {
                       Text("Forgot Password?")
                           .foregroundColor(.white)
                           .underline()
                   }
                   .padding(.top)

                   // Navigation to ForgotPasswordView
                   NavigationLink(destination: ForgotPasswordView(), isActive: $navigateToForgotPassword) {
                       EmptyView()
                   }
                }
            }
        }
        
    }
    
}

#Preview {
    LoginView()
}
           
