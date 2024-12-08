import SwiftUI

struct HeartView: View {
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.Custom.yellow)
                .frame(width: 40, height: 40)
            
            Image(systemName: "bubble.fill")
                .foregroundStyle(Color.Custom.black)
                .font(.title2)
                .offset(y: 2)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.Custom.yellow)
                .font(.footnote)
        }
    }
}

//#Preview {
//    HeartView()
//}
