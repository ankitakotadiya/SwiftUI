import SwiftUI

struct MovieCell: View {
    var imageWidth: CGFloat = 100
    var imageHeight: CGFloat = 140
    var title: String? = "Movie Title"
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    var imageURL: URL?
    @ScaledMetric private var fontSize: CGFloat = 100
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: -8) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: fontSize, weight: .medium, design: .serif))
                    .foregroundStyle(.white)
                    .offset(y: 20)
            }
            
            ZStack(alignment: .bottom) {
                AsyncImageView(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                
                VStack(spacing: 5) {
                    if let title {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                    Text("Recently Added")
                    
                        .font(.caption2)
                        .fontWeight(.medium)
                        .padding(4)
                        .padding(.bottom, 2)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.Custom.red)
                        }
                        .offset(y: 2)
                        .opacity(isRecentlyAdded ? 1 : 0)
                    
                }
                .lineLimit(1)
                .foregroundStyle(.white)
                .padding(5)
                .padding(.top, 6)
                .background {
                    LinearGradient(colors: [.black.opacity(0), .black.opacity(0.3), .black.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                }
            }
            .frame(width: imageWidth, height: imageHeight)
            .cornerRadius(10)
        }
    }
}

//#Preview {
//    MovieCell()
//}
