

import Foundation

struct Student {
    var firstName: String
    var lastName: String
    var age: Int
    var classId: Int
    var gender: String
    var username: String
    var password: String
}

struct ParentInfo {
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var address: String
    var phoneNumber: String
    var gender: String
    var students: [Student]
}

class ParentRegistrationService {
    
    static let shared = ParentRegistrationService()
    
    private init() {}
    
    func registerParent(parentInfo: ParentInfo, completion: @escaping (Result<String, Error>) -> Void) {
      
        guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/registration/") else {
            print("Invalid URL")
            return
        }
        
       
        let parentDictionary: [String: Any] = [
            "user": [
                "username": parentInfo.username,
                "first_name": parentInfo.firstName,
                "last_name": parentInfo.lastName,
                "email": parentInfo.email,
                "password": parentInfo.password
            ],
            "address": parentInfo.address,
            "phone_number": parentInfo.phoneNumber,
            "gender": parentInfo.gender,
            "children": parentInfo.students.map { student in
                return [
                    "first_name": student.firstName,
                    "last_name": student.lastName,
                    "age": student.age,
                    "class_id": student.classId,
                    "gender": student.gender,
                    "username": student.username,
                    "password": student.password
                ]
            }
        ]
        
        print("parent registration--------",parentDictionary)
        
        
        // Convert dictionary to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parentDictionary) else {
            print("Failed to convert dictionary to JSON")
            return
        }
        
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Execute the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                completion(.success("An Invitation link has been send to your registered email. Please accept the invitation "))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Registration failed. Try Again.."])))
            }
        }.resume()
    }
}
