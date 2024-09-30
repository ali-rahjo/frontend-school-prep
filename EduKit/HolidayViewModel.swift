import Foundation
import Combine
import SwiftUI

class HolidayImageFetcher: ObservableObject {
    @Published var image: UIImage?

    private var cancellables = Set<AnyCancellable>()

    func fetchHolidayImage() {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/holiday/list/") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .tryMap { data -> String in
                // Convert data to a string (HTML content)
                guard let htmlString = String(data: data, encoding: .utf8) else {
                    throw URLError(.badServerResponse)
                }
                return htmlString
            }
            .flatMap { htmlString in
                self.extractImageUrl(from: htmlString)
            }
            .flatMap { imageUrl in
                self.fetchImage(from: imageUrl)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching image: \(error)")
                }
            }, receiveValue: { [weak self] image in
                self?.image = image
            })
            .store(in: &cancellables)
    }

    private func extractImageUrl(from htmlString: String) -> AnyPublisher<URL, Error> {
        let imageRegex = "<img src=\"(.*?)\""
        let matches = try? NSRegularExpression(pattern: imageRegex, options: [])
        let nsString = htmlString as NSString
        let results = matches?.matches(in: htmlString, options: [], range: NSRange(location: 0, length: nsString.length))

        if let result = results?.first, let range = Range(result.range(at: 1), in: htmlString) {
            let imagePath = String(htmlString[range])
            // Construct the full URL if necessary
            let fullImageUrl = URL(string: "http://192.168.0.219:8000\(imagePath)")!
            return Just(fullImageUrl)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }

    private func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .map { UIImage(data: $0) }
            .mapError { error in
              
                return error as Error
            }
            .eraseToAnyPublisher()
    }
}

