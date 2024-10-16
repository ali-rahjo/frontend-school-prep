import SwiftUI

struct TeamMember: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let imageName: String
}

struct AboutUsView: View {
    
 
    let teamMembers = [
        TeamMember(name: "Ginu George", role: "Frontend", imageName: "person1"),
        TeamMember(name: "Sayli Mane", role: "Backend", imageName: "person2"),
        TeamMember(name: "Neha Grime", role: "Backend", imageName: "person3"),
        TeamMember(name: "Delo ", role: "Backend", imageName: "person4"),
        TeamMember(name: "Ali", role: "Backend", imageName: "person5")
    ]
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
               
                Text("About Us")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .padding(.leading,120)
                
                Text("We are a team of dedicated professionals working together to deliver exceptional results. Our goal is to provide innovative solutions to our clients.")
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .font(.custom("Noteworthy", size: 26))
                
               
                Text("Our Team")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .padding(.leading,120)
                
               
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(teamMembers) { member in
                        VStack {
                            
                            Image(member.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.all, 10)
                               
                          
                            Text(member.name)
                                .font(.headline)
                                .padding(.top, 5)
                                .foregroundColor(.white)
                            
                            Text(member.role)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }.background( LinearGradient(
            gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                        Color(red: 0/255, green: 0/255, blue: 150/255)]),
            startPoint: .top,
            endPoint: .bottom
 ))
       
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
