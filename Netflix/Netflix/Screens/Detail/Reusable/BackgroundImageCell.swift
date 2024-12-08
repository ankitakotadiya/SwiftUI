import SwiftUI

struct BackgroundImageCell: View {
    private let progress: Double = 0.8
    var imageURL: URL? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            AsyncImageView(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            }
            .frame(height: 300)
            .clipped()
            .overlay(alignment: .bottom) {
                ProgressView(value: progress, total: 1)
                    .progressViewStyle(.linear)
                    .tint(Color.Custom.red)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .bottom)
            }
            
            HStack(spacing: 5) {
                headerButtons(for: "tv.badge.wifi")
                headerButtons(for: "xmark")
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            
        }
        .frame(maxHeight: 300)
    }
    
    private func headerButtons(for label: String) -> some View {
        Button(action: {
            
        }, label: {
            Image(systemName: label)
                .foregroundStyle(.white)
        })
        .padding(8)
        .background {
            Circle()
                .fill(Color.Custom.gray)
        }
    }
}

//#Preview {
//    BackgroundImageCell()
//}
