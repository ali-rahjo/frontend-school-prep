
import Foundation



struct Period: Identifiable, Codable {
    let id = UUID()
    let period: Int
    let subject: String
}

struct TimetableContent: Codable {
       let Monday: [Period]
       let Tuesday: [Period]
       let Wednesday: [Period]
       let Thursday: [Period]
       let Friday: [Period]
    
    
    subscript(day: String) -> [Period]? {
            switch day {
            case "Monday": return Monday
            case "Tuesday": return Tuesday
            case "Wednesday": return Wednesday
            case "Thursday": return Thursday
            case "Friday": return Friday
            default: return nil
            }
        }
}


struct TimetableResponse: Identifiable, Codable {
    let id: Int 
    let timetableContent:TimetableContent
    let teacherID: Int
    let classID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case timetableContent = "timetable_content"
        case teacherID = "teacher"
        case classID = "class_id"
    }
}

