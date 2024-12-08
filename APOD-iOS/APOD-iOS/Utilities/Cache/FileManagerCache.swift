import Foundation
import UIKit

protocol FileManagerCaching {
    func cacheImage(_ image: UIImage, for key: String)
    func retrieveImage(for key: String) -> UIImage?
    var cacheDirectoryURL: URL? {get}
    func createDirectoryifNeeded()
    func fetchAllImages() -> [URL]
}

final class FileManagerCache: FileManagerCaching {
    
    static let shared = FileManagerCache()
    
    private let fileManager: FileManager = {
        FileManager.default
    }()
    
    private var directoryName: String = "ImageCache"
    
    init(directoryName: String = "ImageCache") {
        self.directoryName = directoryName
    }
    
    var cacheDirectoryURL: URL? {
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        return cacheDirectory?.appendingPathComponent(directoryName, isDirectory: true)
    }
    
    func createDirectoryifNeeded() {
        guard let cacheDirectoryURL else {return}
        
        if !fileManager.fileExists(atPath: cacheDirectoryURL.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                // Handle Error
            }
        }
    }
    
    private func createKey(for key: URL) -> String {
        key.absoluteString
    }
    
    func cacheImage(_ image: UIImage, for key: String) {
        createDirectoryifNeeded()
        guard let fileURL = cacheDirectoryURL?.appendingPathComponent(key) else { return }
        
        guard let imageData = image.pngData() else {return}
        
        do {
            try imageData.write(to: fileURL, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieveImage(for key: String) -> UIImage? {
        guard let fileURL = cacheDirectoryURL?.appendingPathComponent(key) else { return nil}
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("No image found at \(fileURL.path)")
            return nil
        }
        
        if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
            return image
        }
        
        return nil
    }
    
    func fetchAllImages() -> [URL] {
        guard let cacheDirectoryURL else {
            return []
        }
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectoryURL, includingPropertiesForKeys: [.contentAccessDateKey])
            
//            let sortedFiles = fileURLs.compactMap { url -> (URL, Date)? in
//                let resourceVal = try? url.resourceValues(forKeys: [.contentAccessDateKey])
//                if let accessdate = resourceVal?.contentAccessDate {
//                    return (url, accessdate)
//                }
//                return nil
//            }.sorted(by: {$0.1 > $1.1})
//            
//            print(sortedFiles)
            return fileURLs
        } catch {
            return []
        }
    }
    
    func pruneRecords() {
        let urls = fetchAllImages()
        
        if urls.count > 10 {
            let itemsToDelete = Array(urls.suffix(from: 10))
            print("Items to delete: \(itemsToDelete.count)")
            for file in itemsToDelete {
                do {
                    try fileManager.removeItem(at: file)
                } catch {
                    
                }
            }
        }
    }
    
}
