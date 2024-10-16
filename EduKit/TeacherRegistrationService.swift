

import Foundation

struct TeacherInfo {
    var username: String
    var firstName: String
    var lastName: String
    var password: String
    var gender: String
}

class TeacherRegistrationService {
    
    static let shared = TeacherRegistrationService()
    
    private init() {}
    
    func registerTeacher(teacherInfo: TeacherInfo, completion: @escaping (Result<String, Error>) -> Void) {
      
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/teacher/registration/") else {
                   print("Invalid URL")
                   completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                   return
               }
               
               let teacherDictionary: [String: Any] = [
                   "user": [
                       "username": teacherInfo.username,
                       "first_name": teacherInfo.firstName,
                       "last_name": teacherInfo.lastName,
                       "password": teacherInfo.password
                   ],
                   "gender": teacherInfo.gender,
                  
               ]
               
             
               guard let jsonData = try? JSONSerialization.data(withJSONObject: teacherDictionary) else {
                   print("Failed to convert dictionary to JSON")
                   completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data"])))
                   return
               }
               
            
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.httpBody = jsonData
               
              
               URLSession.shared.dataTask(with: request) { data, response, error in
                   if let error = error {
                       completion(.failure(error))
                       return
                   }
                   
                   if let httpResponse = response as? HTTPURLResponse {
                       print("Response status code: \(httpResponse.statusCode)")

                       if httpResponse.statusCode == 201 {
                          
                           if let data = data, let responseString = String(data: data, encoding: .utf8) {
                               print("Success response: \(responseString)")
                               completion(.success("Registration successful!"))
                           } else {
                               print("No response body received.")
                               completion(.failure("Registration failed. No response body received." as! Error))

                           }
                       } else {
                          
                           if let data = data,
                              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                              let errorMessage = json["error"] as? String {
                               print("Failure response: \(errorMessage)")
                               completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                           } else {
                               print("No failure response body.")
                               completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Unexpected error occurred."])))
                           }
                       }
                   }
               }.resume()
    }
}
