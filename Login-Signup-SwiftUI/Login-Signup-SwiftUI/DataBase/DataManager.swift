import SwiftUI

@propertyWrapper
struct AppStorageCodable<T: Codable> {
    let key: String
    let storage: AppStorage<String?>
    
    init(key: String) {
        self.key = key
        self.storage = AppStorage(key)
    }
    
    var wrappedValue: T? {
        get {
            guard let json = storage.wrappedValue else {return nil}
            return try? JSONDecoder().decode(T.self, from: Data(json.utf8))
            
        } set {
            if let newVal = newValue, let encode = try? JSONEncoder().encode(newVal)  {
                storage.wrappedValue = String(data: encode, encoding: .utf8)
            } else {
                storage.wrappedValue = nil
            }
        }
    }
}
