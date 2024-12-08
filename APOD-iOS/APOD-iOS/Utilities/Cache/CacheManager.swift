import Foundation
import UIKit

final class CacheManager {
    
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func setObject(for key: String, value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
