import SwiftUI

// View that asynchronously loads an image from a URL and displays it with custom content.
struct AsyncImageView<Content: View>: View {
    
    let url: URL?
    let imageContent: (Image) -> Content
    let onTapFailedImage: (() -> Void)?
    @ScaledMetric(relativeTo: .callout) private var imageWidth: CGFloat = 50
    
    init(
        url: URL?,
        @ViewBuilder imageContent: @escaping (Image) -> Content,
        onTapFailedImage: (() -> Void)? = nil
    ) {
        self.url = url
        self.imageContent = imageContent
        self.onTapFailedImage = onTapFailedImage
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .dynamicTypeAccessibility(.preset)
                    .accessibilityIdentifier(Identifiers.View.imageIndicator)
            case .success(let image):
                imageContent(image)
            case .failure:
                CustomImage(
                    .system,
                    name: Images.failedImage,
                    width: imageWidth,
                    height: imageWidth
                )
                .onTapGesture {
                    onTapFailedImage?()
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}

//#Preview {
//    AsyncImageView()
//}
