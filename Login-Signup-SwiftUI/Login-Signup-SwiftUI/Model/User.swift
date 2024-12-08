import SwiftUI
import Foundation

struct User: Codable {
    let ID: UUID
    var name: String
    let email: String
    var password: String
    var isRemember: Bool
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = .abbreviated
        
        if let component = formatter.personNameComponents(from: name) {
            return formatter.string(from: component)
        }
        return ""
    }
    
    init(ID: UUID = UUID(), name: String, email: String, password: String, isRemember: Bool) {
        self.ID = ID
        self.name = name
        self.email = email
        self.password = password
        self.isRemember = isRemember
    }
}
