import Foundation

enum MediaType: String {
    case image = "image"
    case video = "video"
    case gif = "gif"
    case other = "other"
}

// Apod model contains APOD properties
struct Apod: Codable, Equatable, Hashable {
    var id: String = UUID().uuidString
    let date: String
    let explanation: String
    let media_type: String
    let title: String
    let service_version: String
    let url: URL?
    var isFavourite: Bool = false
    var isMigrationTest: String = ""
    
    // The mediaType property dynamically determines the type based on the media URL's file extension.
    var mediaType: MediaType {
        if let url = url, url.pathExtension.lowercased() == "gif" {
            return .gif
        }
        
        return MediaType(rawValue: media_type) ?? .other
    }
    
    // Coding keys exclude `isFavourite`
    private enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case media_type
        case title
        case service_version
        case url
    }
    
    static func == (lhs: Apod, rhs: Apod) -> Bool {
        return lhs.date == rhs.date && lhs.explanation == rhs.explanation && lhs.media_type == rhs.media_type && lhs.title == rhs.title && lhs.service_version == rhs.service_version && lhs.url == rhs.url && lhs.isFavourite == rhs.isFavourite
    }
}

extension Apod {
    static func getApod(params: [String: String]) -> Request<Apod> {
        return Request(method: .get, path: "/apod", queryParams: params)
    }
    
    static func getList(params: [String:String]) -> Request<[Apod]> {
        return Request(method: .get, path: "/apod", queryParams: params)
    }
    
    // The dummyObj provides a sample static object used for testing or fallback scenarios.
    static var dummyObj: Self {
        return Apod(
            id: UUID().uuidString,
            date: "2024-11-12",
            explanation: "In this stunning cosmic vista, galaxy M81 is on the left surrounded by blue spiral arms.  On the right marked by massive gas and dust clouds, is M82. These two mammoth galaxies have been locked in gravitational combat for the past billion years. The gravity from each galaxy dramatically affects the other during each hundred million-year pass. Last go-round, M82's gravity likely raised density waves rippling around M81, resulting in the richness of M81's spiral arms. But M81 left M82 with violent star forming regions and colliding gas clouds so energetic the galaxy glows in X-rays. In a few billion years only one galaxy will remain. In a few billion years only one galaxy will remain.",
            media_type: "image",
            title: "Galaxy Wars: M81 versus M82",
            service_version: "v1",
            url: URL(
                string: "https://apod.nasa.gov/apod/image/1707/ic342_rector1024s.jpg"
            ), 
            isFavourite: false
        )
    }
}
