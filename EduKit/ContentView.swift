
import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 0) {
                
                  HStack {
                  
                 
                }
                .background(Color(red: 33/255, green: 151/255, blue: 189/255))
                .frame(height: 50)
                .edgesIgnoringSafeArea(.horizontal)
                .padding(.top)
                
                ZStack {
                    Image("slide7")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                    
                    Color.black
                        .opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("genie1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                }
                .padding(.bottom, 20)
                .background(Color(red: 164/255, green: 223/255, blue: 239/255))
                
               
                HStack {
                    NavigationLink(destination: AboutUsView()) {
                        Text("About Us")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: LoginSelection()) {
                         Text("Home")
                             .foregroundColor(.white)
                             .padding()
                     }
                    
                    
                    Spacer()
                    
                    NavigationLink(destination: ContactUsView()) {
                        Text("Contact Us")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .background(Color(red: 33/255, green: 151/255, blue: 189/255))
                .edgesIgnoringSafeArea(.horizontal)
                
               
            }
            .background(Color(red: 164/255, green: 223/255, blue: 239/255))
            .edgesIgnoringSafeArea(.top)
           
           
        }
    }
}



struct AboutUsView: View {
    var body: some View {
        Text("About Us Page")
            .font(.largeTitle)
            .padding()
            .navigationTitle("About Us")
    }
}

struct ContactUsView: View {
    var body: some View {
        Text("Contact Us Page")
            .font(.largeTitle)
            .padding()
            .navigationTitle("Contact Us")
    }
}

#Preview {
    ContentView()
}
