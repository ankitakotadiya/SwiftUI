import Foundation
import SwiftUI
import UIKit

// This `AnimatedGifImageView` struct is a SwiftUI `UIViewRepresentable` that asynchronously loads and displays an animated GIF in a `UIImageView` from a provided URL using a network manager.
struct AnimatedGifImageView: UIViewRepresentable {
    var url: URL?
    var networkManager: NetworkFetching = NetworkManager()
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        Task {
            await loadGif(from: url, into: imageView)
        }
        return imageView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    //This function loads the GIF from the provided URL asynchronously, and sets the loaded GIF image in the UIImageView.
    @MainActor
    private func loadGif(from url: URL?, into imageView: UIImageView) async {
        isLoading = true
        let result = await networkManager.downloadData(from: url)
        switch result {
        case .success(let data):
            isLoading = false
            let animatedImage = UIImage.gifImageWithData(data)
            imageView.image = animatedImage
        case .failure(_):
            isLoading = false
            imageView.image = nil
        }
    }
}


