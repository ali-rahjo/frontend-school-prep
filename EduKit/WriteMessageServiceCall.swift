
import Foundation


struct MessageApplication: Codable {
    let parent_id: Int
    let student_id: Int
    let text_msg: String
    let response: String
   
}


func applyMessage(application: MessageApplication, completion: @escaping (Result<Void, Error>) -> Void) {
    guard let url = URL(string: "http://192.168.0.219:8000/api/v1/parent/write/message/") else {
        completion(.failure(URLError(.badURL)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    print(application)
    do {
        let jsonData = try JSONEncoder().encode(application)
        request.httpBody = jsonData
        if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
               let jsonReadableData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
               if let jsonString = String(data: jsonReadableData, encoding: .utf8) {
                   print("Body -----\n\(jsonString)")
               }
           }
    } catch {
        completion(.failure(error))
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let data = data {
            let responseDataString = String(data: data, encoding: .utf8) ?? "Unable to read response data"
            print("Response data: \(responseDataString)")
        }
        
        
        if let httpResponse = response as? HTTPURLResponse,
         
                    
           httpResponse.statusCode == 200 || httpResponse.statusCode == 201{
            completion(.success(()))
        } else {
            completion(.failure(URLError(.badServerResponse)))
        }
    }
    
    task.resume()
}

