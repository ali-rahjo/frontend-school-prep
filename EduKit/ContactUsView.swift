import SwiftUI

struct ContactUsView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""

    var body: some View {
      
           
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    // Input Fields
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Contact Us")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                            .padding(.leading,120)
                        
                        Text("Name")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                        TextField("Your Name", text: $name)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                        
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                        TextField("Your Email", text: $email)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                        
                        Text("Message")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                        TextEditor(text: $message)
                            .frame(height: 150)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                   
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
                            .padding(.leading,50)
                            
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                   
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Other ways to reach us:")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.white)
                            Text("+1 (123) 456-7890") .foregroundColor(Color.white)
                        }
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.white)
                            Text("ginu@gmail.com") .foregroundColor(Color.white)
                        }
                        
                        HStack {
                            Image(systemName: "map.fill")
                                .foregroundColor(.white)
                            Text("123 Main Street, hamburg, Germany") .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
               
               
                
                .padding(.top)
            }.background( LinearGradient(
                gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                            Color(red: 0/255, green: 0/255, blue: 150/255)]),
                startPoint: .top,
                endPoint: .bottom
     ))
        }
    
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

