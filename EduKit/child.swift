import Foundation

struct Teacher {
    let id: Int
    let username: String
    let firstName: String
    let lastName: String
    let email: String
    let dateJoined: String
    let gender: String

    // Computed property for full name
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

struct Child: Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let classInfo: ClassInfo
    let gender: String
    let username: String
    let teacher:Teacher?
   
}


struct ClassInfo {
    let id: Int
    let className: String
    let academicYearStart: Int
    let academicYearEnd: Int
    let grade: Int
}
