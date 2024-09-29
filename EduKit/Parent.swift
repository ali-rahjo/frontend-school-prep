import SwiftUI

struct Parent: View {
    @State private var isMenuOpen = false
    @State private var isLoading = true
    @State private var parentProfile: [String: Any] = [:]

    var body: some View {
        ZStack {
           
            if isLoading {
                            // Show a loading spinner while data is being fetched
                            VStack {
                                ProgressView("Loading...") // Loading indicator
                                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                                    .scaleEffect(1.5)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .navigationBarHidden(true)
            } else {
            
            
                VStack {
                    // Top section with background gradient and user details
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 250)

                        VStack(spacing: 16) {
                            Image(systemName: "person.circle.fill") // Placeholder for profile picture
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                            
                            

                            
                            if let user = parentProfile["user"] as? [String: Any],
                                    let firstName = user["first_name"] as? String,
                                    let lastName = user["last_name"] as? String {
                                    Text("\(firstName.capitalized) \(lastName.capitalized)")
                                    .font(.title)
                                    .foregroundColor(.white)
                            } else {
                                    Text("Anna Avetisyan")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 60)
                    }

                    Form {
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.purple)
                            if let user = parentProfile["user"] as? [String: Any],
                                let username = user["username"] as? String {
                                Text(username)
                            } else {
                                Text("Anna Avetisyan") // Fallback if no data yet
                            }
                            Spacer()
                        }

                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.purple)
                            if let user = parentProfile["user"] as? [String: Any],
                               let email = user["email"] as? String {
                                Text(email)
                            } else {
                                Text("info@aplusdesign.co")
                            }
                            
                            Spacer()
                        }

                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.purple)
                            if let gender = parentProfile["gender"] as? String {
                                Text(gender == "M" ? "Male" : (gender == "F" ? "Female" : "Unknown"))
                            } else {
                                Text("M")
                            }
                            
                            Spacer()
                        }

                        HStack {
                            Image(systemName: "house")
                                .foregroundColor(.purple)
                            if let address = parentProfile["address"] as? String {
                                Text(address)
                            } else {
                                Text("Address not available") // Fallback
                            }
                            
                            Spacer()
                        }

                        HStack {
                            Image(systemName: "phone")
                                .foregroundColor(.purple)
                            if let phoneNumber = parentProfile["phone_number"] as? String {
                                Text(phoneNumber)
                            } else {
                                Text("Phone number not available") // Fallback
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.purple)
                                if let user = parentProfile["user"] as? [String: Any],
                                   let dateJoined = user["date_joined"] as? String {
                                    let formattedDate = formatDate(dateString: dateJoined)
                                    Text(formattedDate)
                                } else {
                                    Text("Date not available")
                                }
                                Spacer()
                            }
                        
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.purple)
                            Text("Password")
                            Spacer()
                        }

                        // Edit Profile Button
                        Button(action: {
                            // Handle edit profile action
                        }) {
                            Text("Edit Profile")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                    }
                    .padding(.top, -20)
                }
                
                .navigationBarBackButtonHidden(true)
                .offset(x: isMenuOpen ? 250 : 0) // Move content when menu is open
                .animation(.easeInOut, value: isMenuOpen)
            }

            // Semi-transparent background when menu is open
            if isMenuOpen {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }

                // Side menu
                SideMenuView()
                    .frame(width: 270)
                    .background(Color.gray.opacity(0.9))
                   
                    .offset(x: isMenuOpen ? -80 : -100) // Ensure it moves in from the left
                    .animation(.easeInOut, value: isMenuOpen)

            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
        }
        .onAppear {
                    // Call the ParentProfileService when the view appears
                    ParentProfileService.shared.getParentProfile { result in
                        switch result {
                        case .success(let profile):
                            DispatchQueue.main.async {
                                self.parentProfile = profile
                                self.isLoading = false
                            }
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                            self.isLoading = false
                        }
                    }
        }
    }
    
    func formatDate(dateString: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = inputFormatter.date(from: dateString) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd-yyyy-MM" // Output format with only the date
                return outputFormatter.string(from: date)
            }
            return "Invalid date" // Return a fallback if parsing fails
        }
}

