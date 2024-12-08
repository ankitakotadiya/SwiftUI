import SwiftUI

struct ShareButton: View {
    var shareURL: String = "https://medium.com/me/notifications"
    
    @ViewBuilder
    var body: some View {
        
        if let url = URL(string: shareURL) {
            ShareLink(item: url) {
                
                VStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                    
                    Text("Share")
                        .font(.callout)
                        .foregroundStyle(Color.Custom.lightGray)
                }
                .foregroundStyle(.white)
                .padding(8)
            }
        }
    }
}

//#Preview {
//    ShareButton()
//}
