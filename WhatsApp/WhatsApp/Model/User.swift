import Foundation

struct User: Identifiable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let email: String
    let image: String?
    let date: String
    
    var imageURL: URL? {
        guard let path = image else {return nil}
        return URL(string: path)
    }
    
    var callType: String {
        return ["Incoming", "Outgoing", "Missed"].randomElement() ?? "Incoming"
    }
    
    var message: String {
        "Hi! How are you?"
    }
    
    var aboutMe: String {
        "Hey! I am using Whatsapp."
    }
    
    var phone: String {
        "+44 1234567890"
    }
}
