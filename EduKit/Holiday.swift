
import SwiftUI

struct Holiday: View {
  

    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Image("holiday")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .padding(.top,10)
                Spacer()
            }
        }
            
    }
}

    

struct HolidayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Holiday()
    }
}

