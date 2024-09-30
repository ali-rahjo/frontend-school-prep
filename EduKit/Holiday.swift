
import SwiftUI

struct Holiday: View {
    @State private var showImage = false // State variable to control image visibility
    @State private var holidayImage: UIImage? // State variable to store the loaded image

    var body: some View {
        NavigationView {
            VStack {
                
                if showImage, let image = holidayImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 400, maxHeight: .infinity)
                        .clipped()
                } else {
                    ProgressView() // Show a loading spinner while the image is loading
                }
            }.frame(maxWidth: 400, maxHeight: .infinity)
            .onAppear(perform: loadImage) // Load the image when the view appears
        }
    }

    // Function to load the image (simulating network call or local fetch)
    private func loadImage() {
        // Simulate loading image (replace this with your image fetching logic)
        if let url = URL(string: "http://192.168.0.219:8000/static/images/holiday_list/holiday_list.jpg") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.holidayImage = image
                        self.showImage = true // Show the image after loading
                    }
                } else {
                    // Handle the error appropriately (optional)
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    }
}

struct HolidayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Holiday()
    }
}

