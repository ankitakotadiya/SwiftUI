import Foundation

struct Page<T: Decodable>: Decodable {
    
    let users: [T]
    
    enum CodingKeys: String, CodingKey {
        case users
    }
}
