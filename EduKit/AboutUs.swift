

import SwiftUI

struct AboutUs: View {
    
    
       let teamMembers = [
           TeamMember(name: "Ginu George", role: "Frontend", imageName: "person1"),
           TeamMember(name: "Sayli Mane", role: "Backend", imageName: "person2"),
           TeamMember(name: "Neha Grime", role: "Backend", imageName: "person3"),
           TeamMember(name: "Delo ", role: "Backend", imageName: "person4"),
           TeamMember(name: "Ali", role: "Backend", imageName: "person5")
       ]
    
    
    
    var body: some View {
        
               
                Text("About Us")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .padding(.leading,120)
                
           
        
        
    }
}

#Preview {
    AboutUs()
}
