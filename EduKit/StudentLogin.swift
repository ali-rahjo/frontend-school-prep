import SwiftUI

struct StudentLogin: View {
    @State private var username = ""
    @State private var password = ""

    var body: some View {
  
           
            
           
            ZStack {

                Color(red: 253 / 255.0, green: 213 / 255.0, blue: 1 / 255.0)
                VStack {
                               // Welcome label
                               Text("Welcome to")
                                   .font(.title)
                                   .foregroundColor(Color(red: 216 / 255.0, green: 132 / 255.0, blue: 0 / 255.0))
                                   .padding(.top, 50)

                              
                               Text("SchoolPrep")
                                   .font(.custom("ComicSansMS", size: 40))
                                   .foregroundColor(Color(red: 224 / 255.0, green: 153 / 255.0, blue: 1 / 255.0))
                                   .padding(.top, 10)
                    
                     
                               Spacer()
                               
                             
                               Image("logo")
                                   .resizable()
                                   .scaledToFill()
                                 
                                   .frame(width: 90, height: 90)
                                   .clipShape(Circle())
                                   .padding(.bottom, 50)
                }.padding(.top,50)
              
             
            }.background(Color(red: 253 / 255.0, green: 213 / 255.0, blue: 1 / 255.0))
            .frame(height: 350)
            .clipped()
            .padding(.top,0)
            .edgesIgnoringSafeArea(.all)
                
                
                
          
               
            
            
                // Main Content Area
                VStack(spacing: 16) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 340)
                        //.padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 340)
                        //.padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)

                    // Add a login button or other UI elements below
                    Button(action: {
                        // Handle login action
                    }) {
                        Text("Login")
                            .frame(maxWidth: 280) // Make button take full width
                            .padding()
                            .background(Color(red: 255 / 255.0, green: 198 / 255.0, blue: 1 / 255.0))
                      
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .cornerRadius(15)
                .padding(.top, -16)
               
                
                Spacer()
            }
       
    
}

struct StudentLogin_Previews: PreviewProvider {
    static var previews: some View {
        StudentLogin()
    }
}

