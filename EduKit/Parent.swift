import SwiftUI

struct Parent: View {
    @State private var isMenuOpen = false

    var body: some View {
        ZStack {
            // Main content view
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

                        Text("Anna Avetisyan")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 60)
                }

                Form {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.purple)
                        Text("Anna Avetisyan")
                        Spacer()
                    }

                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.purple)
                        Text("Birthday")
                        Spacer()
                    }

                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.purple)
                        Text("818 123 4567")
                        Spacer()
                    }

                    HStack {
                        Image(systemName: "camera")
                            .foregroundColor(.purple)
                        Text("Instagram account")
                        Spacer()
                    }

                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.purple)
                        Text("info@aplusdesign.co")
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
    }
}

