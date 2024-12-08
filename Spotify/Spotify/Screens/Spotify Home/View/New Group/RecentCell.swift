import SwiftUI

struct RecentCell: View {
    var imageURL: URL?
    var title: String = "Some Title"
    var body: some View {
        HStack(spacing: 16) {
            AsyncImageView(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 50)
            .clipped()
            
            Text(title)
                .font(.headline)
                .lineLimit(2)
                .padding(.trailing, 8)
                .padding(.vertical)
                .themeColors(false)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.Custom.gray)
        )
        
    }
}

//#Preview {
//    RecentCell()
//}
