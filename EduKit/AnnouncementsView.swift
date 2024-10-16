        
import SwiftUI

struct Announcement: Codable, Identifiable {
    let id: Int
    let date: String
    let announcement: String
   
}

struct AnnouncementsView: View {
    
    @State private var announcements: [Announcement] = []
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
         
            Image("slide12")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()
            
            VStack {
                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if announcements.isEmpty {
                    Text("Loading announcements...")
                        .foregroundColor(.white)
                        .padding()
                } else {
                    
                    HStack {
                        Text("Announcements")
                            .font(.title)
                            .foregroundColor(.white)
                            
                       
                    }.padding(.top,50)
                        .padding(.leading,40)
                    
                    List(announcements) { announcement in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(announcement.date)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(announcement.announcement)
                                .foregroundColor(.white)
                                .font(.body)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.6))
                        )
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                }
            }.padding(.top,50)
            .onAppear {
                fetchAnnouncements()
            }
        }
    }
    
    func fetchAnnouncements() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/view/announcement") else {
            errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error fetching data: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                }
                return
            }
            
            do {
                let announcementResponse = try JSONDecoder().decode([Announcement].self, from: data)
                DispatchQueue.main.async {
                    announcements = announcementResponse
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

#Preview {
    AnnouncementsView()
}

