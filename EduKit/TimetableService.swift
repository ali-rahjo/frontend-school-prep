import Foundation

class TimetableService {
    static let shared = TimetableService()
    
    private init() {}
    
    func fetchTimetable(classID: Int, completion: @escaping (Result<[TimetableResponse], Error>) -> Void) {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/view/timetable/\(classID)/") else {
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
                
                if httpResponse.statusCode == 200, let data = data {
                    do {
                       
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Response body: \(responseString)")
                        }

                       
                        let decoder = JSONDecoder()
                        let timetableArray = try decoder.decode([TimetableResponse].self, from: data)
                        completion(.success(timetableArray))
                        
                        
                    } catch let parseError {
                        print("JSON decoding error: \(parseError.localizedDescription)")
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


