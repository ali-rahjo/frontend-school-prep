
import SwiftUI

struct TeacherProfile: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        LinearGradient(
                   gradient: Gradient(colors: [Color(red: 0/255, green: 0/255, blue: 50/255),
                                               Color(red: 0/255, green: 0/255, blue: 150/255)]),
                   startPoint: .top,
                   endPoint: .bottom
        )
    }
}

#Preview {
    TeacherProfile()
}
