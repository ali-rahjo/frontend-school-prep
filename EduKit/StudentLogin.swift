import SwiftUI

struct StudentLogin: View {
    @State private var username = ""
    @State private var password = ""

    var body: some View {
  
            ZStack {

                Image("slide8")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .ignoresSafeArea()
                
                VStack {
                              
                               Text("Welcome to")
                                    .font(.custom("Noteworthy-Bold", size: 25))
                                   .foregroundColor(Color.white)
                                   .padding(.bottom, 10)

                              
                               Text("SchoolPrep")
                                   .font(.custom("Noteworthy-Bold", size: 40))
                                   .foregroundColor(Color.white)
                                   .padding(.bottom, 10)
                
                               
                             
                               Image("logo")
                                   .resizable()
                                   .scaledToFill()
                                 
                                   .frame(width: 80, height: 75)
                                   .clipShape(Circle())
                                   .padding(.bottom,30)
                                  
                                   
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 320)
                        //.padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 320)
                        //.padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
                        .padding(.top,20)

                  
                    Button(action: {
                        playSound(sound: "sound-tap", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }) {
                        Text("Login")
                            .frame(maxWidth: 180)
                            .padding()
                            .background(Color.blue)
                            .font(.system(size: 20)) 
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top,30)
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 200)
                }
                .padding(.bottom, 50)
             
            }
           
                
            }
       
}

struct StudentLogin_Previews: PreviewProvider {
    static var previews: some View {
        StudentLogin()
    }
}

