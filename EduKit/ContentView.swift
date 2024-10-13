
import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 0) {
                
                 
                
                ZStack {
                    Image("slide12")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                    
                    Text("SchoolPrep")
                        .font(.custom("Noteworthy-Bold", size: 60))
                        .foregroundColor(Color.white)
                        .padding(.bottom,200)
                    
                       
                    
                    Text("Genie")
                        .font(.custom("Bradley Hand", size: 46))
                        .foregroundColor(Color.white)
                        .padding(.leading, 100)
                        .padding(.bottom,100)
     
                    
                    
                      Image("logo2")
                          .resizable()
                          .scaledToFill()
                        
                          .frame(width: 90, height: 85)
                          .clipShape(Circle())
                          .padding(.top,60)
                      
                   
                    
                 
                }
               
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
                .background(Color.black)
                .edgesIgnoringSafeArea(.horizontal)
                
               
            }
           
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
