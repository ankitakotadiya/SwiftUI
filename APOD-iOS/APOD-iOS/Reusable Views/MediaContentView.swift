import SwiftUI

struct MediaContentView: View {
    var imageName: String
    var mediaURL: URL? = nil
    var mediaType: MediaType
    var maxWidth: CGFloat
    var maxHeightFactor: CGFloat
    var onTappedImage: ((Image) -> Void)?
    var onGifTapped: ((Bool) -> Void)?
//    @Binding var selectedImage: Image?
//    @Binding var gifImageTapped: Bool?
    @ScaledMetric(relativeTo: .callout)  private var imageWidth: CGFloat = 50
    var cache: CacheManager
    var fileManagerCaching: FileManagerCaching
    @State var isLoading: Bool = true
    @State private var isImageDownloadFailed: Bool = false
    
    init(imageName: String, mediaURL: URL? = nil, mediaType: MediaType, maxWidth: CGFloat = .zero, maxHeightFactor: CGFloat = .zero, onTappedImage: ((Image) -> Void)? = nil, onGifTapped: ((Bool) -> Void)? = nil, cache: CacheManager = CacheManager()) {
        self.imageName = imageName
        self.mediaURL = mediaURL
        self.mediaType = mediaType
        self.maxWidth = maxWidth
        self.maxHeightFactor = maxHeightFactor
        self.onTappedImage = onTappedImage
        self.onGifTapped = onGifTapped
        self.cache = cache
        self.fileManagerCaching = FileManagerCache(directoryName: "ImageCache")
    }
    
//    init(
//        imageName: String,
//        mediaURL: URL? = nil,
//        mediaType: MediaType,
//        maxWidth: CGFloat,
//        maxHeightFactor: CGFloat,
//        selectedImage: Binding<Image?> = .constant(nil),
//        gifImageTapped: Binding<Bool?> = .constant(nil)
//    ) {
//        self.imageName = imageName
//        self.mediaURL = mediaURL
//        self.mediaType = mediaType
//        self.maxWidth = maxWidth
//        self.maxHeightFactor = maxHeightFactor
//        self._selectedImage = selectedImage
//        self._gifImageTapped = gifImageTapped
//    }
    
    var body: some View {
        Group {
            if let _url = mediaURL {
                loadMedia(for: mediaType, url: _url)
            } else {
                fallbackImage
            }
        }
        .accessibilityIdentifier(Identifiers.Apod.mediaContentView)
//        .frame(maxWidth: .infinity)
        .frame(width: maxWidth, height: maxHeightFactor)
        .clipped()
    }
}

// View extension methods
extension MediaContentView {
    @ViewBuilder
    private func loadMedia(for type: MediaType, url: URL) -> some View {
        switch type {
        case .image:
            loadImage(_url: url) // Load image if media type is image
        case .video:
            loadVideo(_url: url) // Load video if media type is video
        case .gif:
            loadGif(_url: url) // Load GIF if media type is gif
        case .other:
            fallbackImage // Return fallback if media type is 'other'
        }
    }
    
    private var fallbackImage: some View {
        CustomImage(
            .system,
            name: Images.failedImage,
            width: imageWidth,
            height: imageWidth
        )
    }
    
    // Load an image from the given URL
    @ViewBuilder private func loadImage(_url: URL?) -> some View {
//        if let image = cache.getImage(for: imageName) {
//            displayImage(Image(uiImage: image))
//        }
        if let image = fileManagerCaching.retrieveImage(for: imageName) {
            displayImage(Image(uiImage: image))
        }
        else {
            AsyncImageView(url: _url) { downloadedImage in
                displayImage(downloadedImage)
                    .onAppear {
                        Task {
                            await cachedImaged(downloadedImage)
                        }
                    }
//                    .onChange(of: downloadedImage, perform: { value in
//                        isImageDownloadFailed = false
//                    })
            } onTapFailedImage: {
                isImageDownloadFailed = true
            }
            //            .frame(width: maxWidth, height: maxHeightFactor)
        }
    }
    
    @MainActor
    private func cachedImaged(_ image: Image) {
        if let renderedImage = ImageRenderer(content: image).uiImage {
            //            cache.setObject(for: imageName, value: renderedImage)
            fileManagerCaching.cacheImage(renderedImage, for: imageName)
        }
    }
    
    private func displayImage(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .accessibilityIdentifier(Identifiers.Apod.apodImage)
            .onTapGesture {
                onTappedImage?(image)
            }
    }
    
    private func loadWebContent<T: View>(contentView: T) -> some View {
        ZStack {
            contentView
            
            if isLoading {
                ProgressView()
            }
        }
    }
    
    // Load a video from the given URL
    private func loadVideo(_url: URL?) -> some View {
        loadWebContent(contentView: WebView(url: _url, isLoading: $isLoading))
//        ZStack {
//            WebView(url: _url, isLoading: $isLoading)
//            
//            if isLoading {
//                ProgressView()
//            }
//        }
    }
    
    // Load a GIF from the given URL
    private func loadGif(_url: URL?) -> some View {
        loadWebContent(
            contentView: AnimatedGifImageView(
                url: _url,
                isLoading: $isLoading
            )
            .onTapGesture {
                onGifTapped?(true)
            }
        )
//        ZStack {
//            AnimatedGifImageView(url: _url, isLoading: $isLoading)
//                .onTapGesture {
//                    onGifTapped?(true)
//                }
//            
//            if isLoading {
//                ProgressView()
//            }
//        }
    }
}

//#Preview {
//    MediaContentView()
//}
