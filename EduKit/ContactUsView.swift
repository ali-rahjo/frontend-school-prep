import SwiftUI

struct ContactUsView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""

    var body: some View {
        
        ZStack{
        
        LinearGradient(
            gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                        Color(red: 0/255, green: 0/255, blue: 150/255)]),
            startPoint: .top,
            endPoint: .bottom
        )
      
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Contact Us")
                        .font(.custom("Noteworthy", size: 25))
                        .fontWeight(.bold)
                        .padding(.top, 1)
                        .foregroundColor(.white)
                        .padding(.leading, 120)
                    
                    Text("Name")
                        .font(.custom("Noteworthy", size: 20))
                        .foregroundColor(Color.white)
                        .padding(.leading,10)
                    
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .frame(width: 310)
                        
                    
                    Text("Email")
                        .font(.custom("Noteworthy", size: 20))
                        .foregroundColor(Color.white)
                        .padding(.leading,10)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .frame(width: 310)
                        
                    
                    Text("Message")
                        .font(.custom("Noteworthy", size: 20))
                        .foregroundColor(Color.white)
                        .padding(.leading,10)
                    
                    TextEditor(text: $message)
                        .frame(width: 280, height: 100)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top,50)
                
                Button(action: {
                    print("Name: \(name)")
                    print("Email: \(email)")
                    print("Message: \(message)")
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 250)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.leading, 30)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Other ways to reach us")
                        .font(.custom("Noteworthy", size: 20))
                        .foregroundColor(Color.white)
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.white)
                        Text("+1 (123) 456-7890")
                            .foregroundColor(Color.white)
                            
                    }
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                        Text("schoolprep@gmail.com")
                            .foregroundColor(Color.white)
                           
                    }
                    
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.white)
                        Text("Schmalenbecker Street 23, Hamburg, Germany")
                            .foregroundColor(Color.white)
                            .font(.custom("Noteworthy", size: 18))
                            
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, -5)
            }
            .padding(.top,40)
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                        Color(red: 0/255, green: 0/255, blue: 150/255)]),
            startPoint: .top,
            endPoint: .bottom
        ))
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

