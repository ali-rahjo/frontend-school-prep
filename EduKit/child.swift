import Foundation

struct Child: Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let classInfo: ClassInfo
    let gender: String
    let username: String
}

struct ClassInfo {
    let id: Int
    let className: String
    let academicYearStart: Int
    let academicYearEnd: Int
    let grade: Int
}
