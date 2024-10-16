

import Foundation


struct Students: Codable {
    var id: Int
    var first_name: String
    var last_name: String
    var age: Int
    var class_info: ClassInfoo
    var gender: String
    var username: String
    var teacher_info: TeacherInfoo
}

struct ClassInfoo: Codable {
    var id: Int
    var class_name: String
    var academic_year_start: Int
    var academic_year_end: Int
    var grade: Int
}

struct TeacherInfoo: Codable {
    var id: Int
    var user: User
    var gender: String
}

struct User: Codable {
    var id: Int
    var username: String
    var first_name: String
    var last_name: String
    var email: String
    var date_joined: String
}
