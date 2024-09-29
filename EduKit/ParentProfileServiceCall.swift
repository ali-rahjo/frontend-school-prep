
import Foundation


class ParentProfileService {
    
    static let shared = ParentProfileService()
    
    private init() {}
    
    func getParentProfile(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        // Define the URL for the request
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/profile/") else {
            print("Invalid URL")
            return
        }

        // Create a URL request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Start a URLSession data task
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                completion(.failure(error))
                return
            }

            // Handle response
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                
                // On success (status code 200)
                if httpResponse.statusCode == 200, let data = data {
                    do {
                        // Parse the response JSON data
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Success response: \(jsonResponse)")
                            completion(.success(jsonResponse))
                        }
                    } catch let parseError {
                        completion(.failure(parseError))
                    }
                } else {
                    // On failure, print response data
                    if let data = data, let errorResponse = String(data: data, encoding: .utf8) {
                        print("Failure response: \(errorResponse)")
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse])))
                    } else {
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Unexpected error occurred."])))
                    }
                }
            }
        }.resume()
    }
}
