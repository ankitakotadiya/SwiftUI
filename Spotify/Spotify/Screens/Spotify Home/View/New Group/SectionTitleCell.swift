import SwiftUI

struct SectionTitleCell: View {
    var imageSize: CGFloat = 100
    var imageURL: URL?
    var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImageView(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: imageSize, height: imageSize)
            .clipped()
            
            Text(title)
                .font(.body)
                .foregroundStyle(Color.Custom.lightGray)
                .lineLimit(2)
        }
        .frame(width: imageSize)
    }
}

//#Preview {
//    SectionTitleCell()
//}
