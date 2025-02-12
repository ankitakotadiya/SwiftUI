import SwiftUI

struct ProfileImageView: View {
    let imageURL: URL?
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 1.0)
            
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                    
                case .failure(_):
                    Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                @unknown default:
                    EmptyView()
                }
            }
            .clipShape(Circle())
            .padding(8)
        }
        .frame(width: 80, height: 80)
    }
}

//#Preview {
//    ProfileImageView()
//}
