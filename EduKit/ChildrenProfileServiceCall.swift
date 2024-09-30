import Foundation

class ChildrenProfileService {
    static let shared = ChildrenProfileService()
    
    private init() {}

    func getChildrenProfile(completion: @escaping (Result<[Child], Error>) -> Void) {
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/student/info/") else {
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
                        // Ensure JSON response is of type [[String: Any]]
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                            let children: [Child] = jsonResponse.compactMap { dict in
                                // Safely unwrap the required fields from the dictionary
                                guard let id = dict["id"] as? Int,
                                      let firstName = dict["first_name"] as? String,
                                      let lastName = dict["last_name"] as? String,
                                      let age = dict["age"] as? Int,
                                      let gender = dict["gender"] as? String,
                                      let username = dict["username"] as? String,
                                      let classInfo = dict["class_info"] as? [String: Any],
                                      let classID = classInfo["id"] as? Int,
                                      let className = classInfo["class_name"] as? String,
                                      let academicYearStart = classInfo["academic_year_start"] as? Int,
                                      let academicYearEnd = classInfo["academic_year_end"] as? Int,
                                      let grade = classInfo["grade"] as? Int
                                else {
                                    return nil
                                }
                                
                               
                                let classDetail = ClassInfo(id: classID, className: className, academicYearStart: academicYearStart, academicYearEnd: academicYearEnd, grade: grade)
                                
                              
                                return Child(id: id, firstName: firstName, lastName: lastName, age: age, classInfo: classDetail, gender: gender, username: username)
                            }
                            completion(.success(children))
                        } else {
                            
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format."])))
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

