
import Foundation


class ParentProfileService {
    
    static let shared = ParentProfileService()
    
    private init() {}
    
    func getParentProfile(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/view/profile/") else {
            print("Invalid URL")
            return
        }

       
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

       
        URLSession.shared.dataTask(with: request) { data, response, error in
          
            if let error = error {
                completion(.failure(error))
                return
            }

          
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                 // On success (status code 200)
                if httpResponse.statusCode == 200, let data = data {
                    do {
                      
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Success response: \(jsonResponse)")
                            completion(.success(jsonResponse))
                        }
                    } catch let parseError {
                        completion(.failure(parseError))
                    }
                } else {
                    
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
