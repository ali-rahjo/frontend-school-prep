

import SwiftUI

struct LunchMenuView: View {
    @State private var lunchMenuData: LunchMenuResponse? = nil
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

   
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading Lunch Menu...")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
            } else if let menu = lunchMenuData {
                ScrollView {
                    VStack(spacing: 20) {
                        
                    
                        
                        
                          Image("logo2")
                              .resizable()
                              .scaledToFill()
                            
                              .frame(width: 70, height: 75)
                              .clipShape(Circle())
                              .padding(.bottom,10)

                        Text("\(menu.week_start_date)   to \(menu.week_end_date)")
                            .font(.custom("Bradley Hand", size: 20))
                            .foregroundColor(.purple)
                            .padding(.bottom, 10)

                       
                        ForEach(daysOfWeek, id: \.self) { day in
                            if let weekMenu = menu.lunch_menu["Week 1"],
                               let dishes = weekMenu[day] {
                                KidDayMenuView(day: day, dishes: dishes)
                            }
                        }
                    }
                    .padding()
                }
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                Text("No lunch menu available.")
            }
        }
        .onAppear {
            fetchLunchMenu()
        }
    }

    func fetchLunchMenu() {
        isLoading = true
        
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/view/lunchmenu/") else {
            isLoading = false
            errorMessage = "Invalid URL"
            return
        }
        
      
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                if let data = data {
                    do {
                       
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Response Body: \(jsonString)")
                        }

                       
                        let decodedResponse = try JSONDecoder().decode([LunchMenuResponse].self, from: data)
                        lunchMenuData = decodedResponse.first
                    } catch {
                        errorMessage = "Failed to decode response: \(error.localizedDescription)"
                    }
                }
            }
        }.resume()
    }
}



struct KidDayMenuView: View {
    var day: String
    var dishes: [String]
    
    var body: some View {
        VStack {
            // Fun header for the day
            Text(day)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding()
                .background(Color.yellow)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)

            
            VStack(spacing: 10) {
                ForEach(dishes, id: \.self) { dish in
                    KidDishView(dish: dish)
                }
            }
            .padding()
        }
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct KidDishView: View {
    var dish: String
    
    var body: some View {
        HStack {
            // Add icons for food items
            Image(systemName: "fork.knife.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            Text(dish)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.purple)
            Spacer()
        }
        .padding()
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

// MARK: - Models

struct LunchMenuResponse: Codable {
    var id: Int
    var week_start_date: String
    var week_end_date: String
    var lunch_menu: [String: [String: [String]]]
}

// MARK: - Utility

extension Color {
    // Generate random bright colors for a fun effect
    static func randomBrightColor() -> Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
        return colors.randomElement() ?? .blue
    }
}
