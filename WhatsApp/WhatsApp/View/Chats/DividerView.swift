import SwiftUI

struct DividerView: View {
    
    let leading: Double
    
    var body: some View {
        Divider()
            .padding(.leading, leading)
    }
}

//#Preview {
//    DividerView()
//}
