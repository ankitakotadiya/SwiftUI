import Foundation

struct User: Decodable, Hashable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let email: String
    let image: String?
    let university: String?
    let address: Address?
    let company: Company?
    let height: Double?
    
    var imageURL: URL? {
        guard let path = image else {return nil}
        return URL(string: path)
    }
    
    var userImage: String {
        "dummy-user"
    }
    
    var aboutme: String {
        "This is about me section to check out more details and preferences."
    }
    
    var basics: [UserInterests] {
        [
            UserInterests(iconName: "ruler", emoji: nil, text: "\(height ?? 153)"),
            UserInterests(iconName: "graduationcap", emoji: nil, text: university ?? "MSc. in Computer Science"),
            UserInterests(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterests(iconName: "moon.stars.fill", emoji: nil, text: "Virgo")
        ]
    }
    
    var interests: [UserInterests] {
        [
            UserInterests(iconName: nil, emoji: "👟", text: "Running"),
            UserInterests(iconName: nil, emoji: "🏋️‍♀️", text: "Gym"),
            UserInterests(iconName: nil, emoji: "🎧", text: "Music"),
            UserInterests(iconName: nil, emoji: "🥘", text: "Cooking")
        ]
    }
    
    var userImages: [String] {
        ["dummy1", "dummy2"]
    }
    
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, age, gender, email, image, university, address, company, height
    }
    
    struct Address: Codable, Hashable {
        let address: String
        let city: String
        let state: String
        let stateCode: String
        let postalCode: String
        
        var fullAddress: String {
            return "\(address), \(city), \(stateCode), \(postalCode)."
        }
    }
    
    struct Company: Codable, Hashable {
        let department: String
        let name: String
        let title: String
    }
}

// Extension to define movie-related requests.
extension User {
    static var topUsers: Request<Page<User>> {
        return Request(method: .get, path: "/users")
    }
}


